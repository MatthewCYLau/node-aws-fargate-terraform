const express = require("express");
const connectDB = require("./config/db");

const app = express();

// Connect Database
connectDB();

// Init Middleware
app.use(express.json({ extended: false }));

// Define Routes
app.use("/api/users", require("./routes/api/users"));
app.use("/api/auth", require("./routes/api/auth"));

const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
  res.send("Hello world from a Node.js app!");
});

app.listen(PORT, () => console.log(`Server started on port ${PORT}`));
