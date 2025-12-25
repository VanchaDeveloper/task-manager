import { Request, Response } from "express";
import { container } from "tsyringe";
import { SignUpUseCase } from "../../domain/usecases/signup_usecase";
import { LoginUseCase } from "../../domain/usecases/login_usecase";
import { TokenIsValidUseCase } from "../../domain/usecases/token_is_valid_usecase";
import { GetCurrentUserUseCase } from "../../domain/usecases/get_current_user_usecase";

export class AuthController {
  async signUp(req: Request, res: Response) {
    try {
      const { name, email, password } = req.body;
      const signup = container.resolve(SignUpUseCase);
      const user = await signup.execute({ name, email, password });
      res.status(201).json(user);
    } catch (e) {
      res.status(500).json({ error: (e as Error).message });
    }
  }

  async login(req: Request, res: Response) {
    try {
      const { email, password } = req.body;
      const login = container.resolve(LoginUseCase);
      const { user, token } = await login.execute(email, password);
      res.json({ token, ...user });
    } catch (e) {
      res.status(400).json({ error: (e as Error).message });
    }
  }

  async tokenIsValid(req: Request, res: Response) {
    try {
      const token = req.header("x-auth-token") || "";
      const tokenIsValid = container.resolve(TokenIsValidUseCase);
      const valid = await tokenIsValid.execute(token);
      res.json(valid);
    } catch (e) {
      res.status(500).json(false);
    }
  }

  async getCurrentUser(req: Request, res: Response) {
    try {
      const id = (req as any).user as string;
      const getUser = container.resolve(GetCurrentUserUseCase);
      const user = await getUser.execute(id);
      res.json(user);
    } catch (e) {
      res.status(500).json(false);
    }
  }
}
