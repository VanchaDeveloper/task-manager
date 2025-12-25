import { injectable, inject } from "tsyringe";
import { UserRepository, USER_REPOSITORY } from "../repositories/user_repository";
import { User } from "../entities/user";

@injectable()
export class GetCurrentUserUseCase {
  constructor(@inject(USER_REPOSITORY) private userRepository: UserRepository) {}

  async execute(id: string): Promise<User> {
    const user = await this.userRepository.findById(id);
    if (!user) {
      throw new Error("User not found!");
    }
    return user;
  }
}
