import { injectable } from "tsyringe";
import { UserRepository } from "../../domain/repositories/user_repository";
import { NewUser, User } from "../../domain/entities/user";
import { UserDatasource } from "../datasources/user_datasource";

@injectable()
export class UserRepositoryImpl implements UserRepository {
  constructor(private datasource: UserDatasource) {}

  async create(user: NewUser): Promise<User> {
    return this.datasource.insertUser(user);
  }

  async findByEmail(email: string): Promise<User | undefined> {
    return this.datasource.findByEmail(email);
  }

  async findById(id: string): Promise<User | undefined> {
    return this.datasource.findById(id);
  }
}
