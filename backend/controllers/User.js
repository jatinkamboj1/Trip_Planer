const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const bcrypt = require("bcryptjs");
const otpGenerator = require("otp-generator");
const nodemailer = require("nodemailer");
const jwt = require("jsonwebtoken");
const { response } = require("express");
require("dotenv").config();

exports.registerForm = async (req, res) => {
  res.render("register");
};
exports.verifyotpForm = async (req, res) => {
  res.render("otp");
};
exports.loginForm = async (req, res) => {
  res.render("login");
};

//controllers
exports.register = async (req, res) => {
  const { username, email, password, role, contactnumber } = req.body;
  console.log(req.body);

  const existingUser = await prisma.user.findUnique({
    where: { username },
  });

  // If user exists, update the email and generate a new OTP
  if (existingUser) {
    const otp = otpGenerator.generate(6, {
      upperCase: false,
      specialChars: false,
      digits: true,
    });

    const updatedUser = await prisma.user.update({
      where: { username },
      data: {
        username,
        email,
        otp,
        password: password
          ? await bcrypt.hash(password, await bcrypt.genSalt(10))
          : existingUser.password,
        contactnumber,
      },
    });

    // Send email
    const transporter = nodemailer.createTransport({
      service: "gmail",
      auth: {
        user: "jatinkamboj0010@gmail.com",
        pass: "ujyx domz salq irwi",
      },
    });
    const mailOptions = {
      from: "jatinkamboj0010@gmail.com",
      to: email,
      subject: "Your OTP Code",
      text: `Hello ${username}, your OTP code is: ${otp}`,
      html: `<b>Hello ${username}, your OTP code is: ${otp}</b>`,
    };
    try {
      await transporter.sendMail(mailOptions);
      console.log("Message sent successfully to:", email);
    } catch (error) {
      console.error("Error sending email:", error);
      return res.status(500).json({ message: "Error sending OTP email" });
    }
    res.redirect("/otp");
  } else {
    // If user does not exist, create a new user
    const salt = await bcrypt.genSalt(10);
    const passwordHash = await bcrypt.hash(password, salt);

    const otp = otpGenerator.generate(6, {
      upperCase: false,
      specialChars: false,
      digits: true,
    });

    // Check if there are any existing users in the database
    const existingUsers = await prisma.user.findMany();
    const role = existingUsers.length === 0 ? "admin" : "user";

    const user = await prisma.user.create({
      data: {
        username,
        email,
        otp,
        password: passwordHash,
        contactnumber,
        role,
      },
    });

    // Send email
    const transporter = nodemailer.createTransport({
      service: "gmail",
      auth: {
        user: "jatinkamboj0010@gmail.com",
        pass: "ujyx domz salq irwi",
      },
    });
    const mailOptions = {
      from: "jatinkamboj0010@gmail.com",
      to: email,
      subject: "Your OTP Code",
      text: `Hello ${username}, your OTP code is: ${otp}`,
      html: `<b>Hello ${username}, your OTP code is: ${otp}</b>`,
    };

    try {
      await transporter.sendMail(mailOptions);
      console.log("Message sent successfully to:", email);
    } catch (error) {
      console.error("Error sending email:", error);
      return res.status(500).json({ message: "Error sending OTP email" });
    }
    res.redirect("/otp");
  }
};
exports.verifyotp = async (req, res) => {
  const { email, otp } = req.body;
  console.log(req.body);

  if (!email || !otp) {
    return res.status(400).json({ message: "Email and OTP are required" });
  }
  const user = await prisma.user.findUnique({
    where: { email },
  });
  if (!user) {
    return res.status(404).json({ message: "User not found" });
  }
  if (user.otp !== otp) {
    return res.status(400).json({ message: "Invalid OTP" });
  }
  await prisma.user.update({
    where: { email },
    data: { active: true },
  });
  res.redirect("/login");
};
exports.login = async (req, res) => {
  const { email, password } = req.body;

  const user = await prisma.user.findUnique({
    where: { email },
  });

  if (!user) {
    return res
      .status(404)
      .json({ message: "User not found. Please register first." });
  }

  const isMatch = await bcrypt.compare(password, user.password);
  if (!isMatch) {
    return res.status(400).json({ message: "Invalid credentials" });
  }

  // Generate JWT token
  const token = jwt.sign(
    { userId: user.userId, role: user.role },
    process.env.JWT_SECRET,
    { expiresIn: "1h" }
  );
  console.log("User Role: ", user.role);

  // Set the token in the response header under "Authorization"
  res.setHeader("Authorization", `Bearer ${token}`);

  if (user.role === "admin") {
    res.redirect("/admin/dashboard");
  } else {
    res.redirect("/user/dashboard");
  }
};
// exports.profile = async (req, res) => {

//   const user = await prisma.user.findUnique({
//     where: { userId: req.userId },
//   });

//   if (!user) {
//     return res.status(404).json({ message: "User not found" });
//   }

//   res.json({
//     message: "Profile accessed",
//     user,
//   });
// };

exports.admin = (req, res) => {
  res.json({
    message: "Welcome Admin",
    admin: req.user,
  });
};
exports.user = (req, res) => {
  res.json({ message: "Welcome to the User Dashboard!" });
};
