import 'reflect-metadata';
import "./core/di/container";
import express from "express";
import authRouter from "./framework/routes/auth";
import taskRouter from "./routes/task";
const cors = require('cors');


const app = express();

const allowedOrigins = [
  'http://localhost:3000',
  'http://localhost:57206'
];

app.use(cors({
  origin: ['http://localhost:3000', 'http://localhost:57206'],
  credentials: true
}));

app.use(express.json());
app.use("/auth", authRouter);
app.use("/tasks", taskRouter);

app.get("/", (req, res) => {
  res.send("Welcome to my app!!!!!!!");
});

app.listen(8000, () => {
  console.log("Server started on port 8000");
});
