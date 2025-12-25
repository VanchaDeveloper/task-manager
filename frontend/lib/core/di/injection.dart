import 'package:get_it/get_it.dart';
import 'package:frontend/features/auth/repository/auth_local_repository.dart';
import 'package:frontend/features/auth/repository/auth_remote_repository.dart';
import 'package:frontend/core/services/sp_service.dart';
import 'package:frontend/features/home/repository/task_remote_repository.dart';
import 'package:frontend/features/home/repository/task_local_repository.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  // Auth
  getIt.registerLazySingleton(() => AuthRemoteRepository());
  getIt.registerLazySingleton(() => AuthLocalRepository());
  getIt.registerLazySingleton(() => SpService());

  // Tasks
  getIt.registerLazySingleton(() => TaskRemoteRepository());
  getIt.registerLazySingleton(() => TaskLocalRepository());
}
