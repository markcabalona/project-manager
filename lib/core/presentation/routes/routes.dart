import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/presentation/pages/authenticate_page.dart';
import '../../../features/auth/presentation/pages/otp_validation_page.dart';
import '../../../features/auth/presentation/pages/sign_in_page.dart';
import '../../../features/auth/presentation/pages/sign_up_page.dart';
import '../../../features/project/domain/entities/project.dart';
import '../../../features/project/presentation/pages/homepage.dart';
import '../../../features/project/presentation/pages/project_page.dart';
import '../../login_info.dart';
import '../widgets/error_widget.dart';

final router = GoRouter(
  redirect: (state) {
    final LoginInfo loginInfo = LoginInfo.instance;
    final loggingIn = [
      Routes.login.path,
      Routes.signUp.path,
      Routes.signUp.path + Routes.otp.path
    ].contains(state.subloc);

    if (loggingIn && loginInfo.isLoggedIn) {
      return Routes.home.path;
    } else if (!loginInfo.isLoggedIn && !loggingIn) {
      return Routes.login.path;
    }
    return null;
  },
  refreshListenable: LoginInfo.instance,
  initialLocation: Routes.home.path,
  routes: [
    GoRoute(
      name: Routes.home.name,
      path: Routes.home.path,
      pageBuilder: (context, state) {
        return const MaterialPage(
          child: HomePage(),
        );
      },
    ),
    GoRoute(
      name: Routes.login.name,
      path: Routes.login.path,
      pageBuilder: (context, state) {
        return const MaterialPage(
          child: AuthenticatePage(
            child: Left(
              SignInPage(),
            ),
          ),
        );
      },
    ),
    GoRoute(
      name: Routes.signUp.name,
      path: Routes.signUp.path,
      pageBuilder: (context, state) {
        return const MaterialPage(
          child: AuthenticatePage(
            child: Right(
              SignUpPage(),
            ),
          ),
        );
      },
      routes: [
        GoRoute(
          name: Routes.otp.name,
          path: Routes.otp.pathAsSubRoute,
          pageBuilder: (context, state) {
            return MaterialPage(
              child: OTPValidationPage(
                user: (state.extra as User),
              ),
            );
          },
        ),
      ],
    ),
    GoRoute(
      name: Routes.project.name,
      path: Routes.project.pathWithParams('project_id'),
      pageBuilder: (context, state) {
        return MaterialPage(
          child: ProjectPage(
            projectParams: state.extra != null ? state.extra as Project : null,
            projectID: state.params['project_id']!,
          ),
        );
      },
    ),
  ],
  errorPageBuilder: (context, state) {
    return MaterialPage(
      key: state.pageKey,
      child: const CustomErrorWidget(
        errorMessage: '404 Page Not Found',
      ),
    );
  },
);

class Routes {
  static const Route home = Route(path: '/', name: 'home');
  static const Route login = Route(path: '/login', name: 'login');
  static const Route signUp = Route(path: '/sign-up', name: 'sign-up');
  static const Route otp = Route(path: '/verification', name: 'otp');
  static const Route project = Route(path: '/project', name: 'project');
}

class Route {
  final String path;
  final String name;

  const Route({
    required this.path,
    required this.name,
  });

  String get pathAsSubRoute => path.replaceAll('/', '');
  String pathWithParams(String params) => '$path/:$params';
}
