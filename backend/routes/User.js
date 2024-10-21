const express = require("express");
const {
  register,
  login,
  profile,
  admin,
  verifyotp,
  user,
  registerForm,
  verifyotpForm,
  loginForm,
} = require("../controllers/User");
const router = express.Router();

//routes
router.post("/register", register);
router.post("/verifyotp", verifyotp);
router.post("/login", login);
0// router.post('/profile', profile );
router.get("/admin/dashboard", admin);
router.get("/user/dashboard", user);
router.get("/register", registerForm);
router.get("/otp", verifyotpForm);
router.get("/login", loginForm);

module.exports = router;
