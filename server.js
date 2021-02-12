// server.js

const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("Bonjour world from a Node.js app!");
});

app.listen(3000, () => {
  console.log("Server is up on port 3000");
});
