const mongoose = require("mongoose");

const mongoConnectionString = `mongodb+srv://admin-matlau:${process.env.MONGO_PASSWORD}@mattewcylau-5ltcp.mongodb.net/node-express-mongodb-docker?retryWrites=true`;

const connectDB = async () => {
  try {
    await mongoose.connect(mongoConnectionString, {
      useNewUrlParser: true,
      useCreateIndex: true,
      useFindAndModify: false,
      useUnifiedTopology: true
    });

    console.log("MongoDB Connected...");
  } catch (err) {
    console.error(err.message);
    // Exit process with failure
    process.exit(1);
  }
};

module.exports = connectDB;
