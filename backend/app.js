const express = require("express");
const session = require("express-session");
const users = require("./routes/User");
const secretkey = "kambojkamboj";

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Session middleware
app.use(
  session({
    secret: "mysecret",
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false }, // Set to true if you're using HTTPS
  })
);
app.set("view engine", "ejs");

// Routes
app.use("/", users);

// Start the server
const port = 5000;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
