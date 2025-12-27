import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/cubit/auth_cubit.dart';
import 'package:frontend/features/home/cubit/tasks_cubit.dart';

import 'package:frontend/core/di/injection.dart' as di;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/router/app_router.dart';

void main() {
  di.configureDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => TasksCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return _AuthRouterSync(
          state: state,
          child: MaterialApp.router(
            title: 'Task App',
            theme: ThemeData(
              fontFamily: "Cera Pro",
              inputDecorationTheme: InputDecorationTheme(
                contentPadding: const EdgeInsets.all(27),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              useMaterial3: true,
            ),
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en')],
          ),
        );
      },
    );
  }
}

// Keep routing in sync with auth state
// Schedule a post-frame callback so navigation occurs after build
class _AuthRouterSync extends StatefulWidget {
  final Widget child;
  final AuthState state;

  const _AuthRouterSync({required this.child, required this.state});

  @override
  State<_AuthRouterSync> createState() => _AuthRouterSyncState();
}

class _AuthRouterSyncState extends State<_AuthRouterSync> {
  final appRouter = AppRouter();

  @override
  void didUpdateWidget(covariant _AuthRouterSync oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.state is AuthLoggedIn) {
        appRouter.replaceAll([const HomeRoute()]);
      } else {
        appRouter.replaceAll([const SignupRoute()]);
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
