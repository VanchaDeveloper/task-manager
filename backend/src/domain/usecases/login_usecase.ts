import { injectable, inject } from "tsyringe";
import bcryptjs from "bcryptjs";
import jwt from "jsonwebtoken";
import { UserRepository, USER_REPOSITORY } from "../repositories/user_repository";
import { User } from "../entities/user";
import { JWT_SECRET } from "../../core/config";

@injectable()
export class LoginUseCase {
  constructor(@inject(USER_REPOSITORY) private userRepository: UserRepository) {}

  async execute(email: string, password: string): Promise<{ user: User; token: string }> {
    const user = await this.userRepository.findByEmail(email);
    if (!user) {
      throw new Error("User with this email does not exist!");
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      throw new Error("Incorrect password!");
    }

    const token = jwt.sign({ id: user.id }, JWT_SECRET);

    return { user, token };
  }
}
