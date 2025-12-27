import 'package:auto_route/auto_route.dart';

import 'package:frontend/features/auth/pages/login_page.dart';
import 'package:frontend/features/auth/pages/signup_page.dart';
import 'package:frontend/features/home/pages/add_new_task_page.dart';
import 'package:frontend/features/home/pages/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SignupRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: AddNewTaskRoute.page),
  ];
}
