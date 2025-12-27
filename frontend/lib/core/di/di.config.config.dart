// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:frontend/core/services/sp_service.dart' as _i912;
import 'package:frontend/features/auth/cubit/auth_cubit.dart' as _i790;
import 'package:frontend/features/auth/repository/auth_local_repository.dart'
    as _i1008;
import 'package:frontend/features/auth/repository/auth_remote_repository.dart'
    as _i286;
import 'package:frontend/features/home/cubit/tasks_cubit.dart' as _i384;
import 'package:frontend/features/home/repository/task_local_repository.dart'
    as _i97;
import 'package:frontend/features/home/repository/task_remote_repository.dart'
    as _i413;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i912.SpService>(() => _i912.SpService());
    gh.singleton<_i1008.AuthLocalRepository>(
      () => _i1008.AuthLocalRepository(),
    );
    gh.singleton<_i286.AuthRemoteRepository>(
      () => _i286.AuthRemoteRepository(),
    );
    gh.singleton<_i97.TaskLocalRepository>(() => _i97.TaskLocalRepository());
    gh.singleton<_i413.TaskRemoteRepository>(
      () => _i413.TaskRemoteRepository(),
    );
    gh.singleton<_i790.AuthCubit>(
      () => _i790.AuthCubit(
        authRemoteRepository: gh<_i286.AuthRemoteRepository>(),
        authLocalRepository: gh<_i1008.AuthLocalRepository>(),
        spService: gh<_i912.SpService>(),
      ),
    );
    gh.singleton<_i384.TasksCubit>(
      () => _i384.TasksCubit(
        taskRemoteRepository: gh<_i413.TaskRemoteRepository>(),
        taskLocalRepository: gh<_i97.TaskLocalRepository>(),
      ),
    );
    return this;
  }
}
