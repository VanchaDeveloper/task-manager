import { injectable } from "tsyringe";
import jwt from "jsonwebtoken";
import { JWT_SECRET } from "../../core/config";

@injectable()
export class TokenIsValidUseCase {
  async execute(token: string): Promise<boolean> {
    try {
      if (!token) return false;
      const verified = jwt.verify(token, JWT_SECRET);
      return !!verified;
    } catch (e) {
      return false;
    }
  }
}
