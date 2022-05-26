import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/features/auth/presentation/pages/otp_validation_page.dart';

import '../../../features/auth/presentation/pages/authenticate_page.dart';
import '../../../features/auth/presentation/pages/sign_in_page.dart';
import '../../../features/auth/presentation/pages/sign_up_page.dart';
import '../../../features/project/presentation/pages/homepage.dart';
import '../widgets/error_widget.dart';

class LoginInfo extends ChangeNotifier {
  bool _isLoggedIn = FirebaseAuth.instance.currentUser != null;

  get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

final LoginInfo loginInfo = LoginInfo();

final router = GoRouter(
  redirect: (state) {
    final loggingIn = [
      Routes.login.path,
      Routes.signUp.path,
      Routes.signUp.path + Routes.otp.path
    ].contains(state.subloc);

    log(loggingIn.toString() + state.subloc);
    if (loggingIn && loginInfo.isLoggedIn) {
      return Routes.home.path;
    } else if (!loginInfo.isLoggedIn && !loggingIn) {
      return Routes.login.path;
    }
    return null;
  },
  refreshListenable: loginInfo,
  //GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
  initialLocation: Routes.home.path,
  routes: [
    GoRoute(
      name: Routes.home.name,
      path: Routes.home.path,
      pageBuilder: (context, state) {
        return MaterialPage(
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
}

class Route {
  final String path;
  final String name;
  const Route({
    required this.path,
    required this.name,
  });

  String get pathAsSubRoute => path.replaceAll('/', '');
}
