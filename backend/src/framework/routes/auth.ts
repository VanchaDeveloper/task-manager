import { Router } from "express";
import { AuthController } from "../controllers/auth_controller";
import { auth } from "../../middleware/auth";

const router = Router();
const controller = new AuthController();

router.post("/signup", (req, res) => controller.signUp(req, res));
router.post("/login", (req, res) => controller.login(req, res));
router.post("/tokenIsValid", (req, res) => controller.tokenIsValid(req, res));
router.get("/", auth, (req, res) => controller.getCurrentUser(req, res));

export default router;
