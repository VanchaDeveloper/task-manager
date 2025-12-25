import "reflect-metadata";
import { container } from "tsyringe";
import { USER_REPOSITORY } from "../../domain/repositories/user_repository";
import { UserRepositoryImpl } from "../../data/repositories/user_repository_impl";
import { UserDatasource } from "../../data/datasources/user_datasource";

// Register concrete implementations
container.registerSingleton(USER_REPOSITORY, UserRepositoryImpl);
container.registerSingleton(UserDatasource, UserDatasource);
