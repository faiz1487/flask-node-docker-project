
const express = require("express");
const bodyParser = require("body-parser");
const axios = require("axios");

const app = express();
app.set("view engine", "ejs");

app.use(bodyParser.urlencoded({ extended: true }));

app.get("/", (req, res) => {
  res.render("form");
});

app.post("/submit", async (req, res) => {
  try {
    await axios.post("http://backend:5000/submit", req.body);
    res.send("Form submitted successfully");
  } catch (err) {
    res.send("Error submitting form");
  }
});

app.listen(3000, () => {
  console.log("Frontend running on port 3000");
});
