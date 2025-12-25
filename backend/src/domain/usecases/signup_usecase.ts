import { injectable, inject } from "tsyringe";
import bcryptjs from "bcryptjs";
import { UserRepository, USER_REPOSITORY } from "../repositories/user_repository";
import { NewUser, User } from "../entities/user";

@injectable()
export class SignUpUseCase {
  constructor(@inject(USER_REPOSITORY) private userRepository: UserRepository) {}

  async execute(data: NewUser): Promise<User> {
    const hashedPassword = await bcryptjs.hash(data.password, 8);
    const created = await this.userRepository.create({
      ...data,
      password: hashedPassword,
    });
    return created;
  }
}
