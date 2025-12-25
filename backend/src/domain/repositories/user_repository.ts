import { NewUser, User } from "../entities/user";

export const USER_REPOSITORY = "UserRepository";

export interface UserRepository {
  create(user: NewUser): Promise<User>;
  findByEmail(email: string): Promise<User | undefined>;
  findById(id: string): Promise<User | undefined>;
}
