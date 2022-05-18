import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/presentation/widgets/theme_mode_iconbutton.dart';

import '../../../project/presentation/bloc/project_bloc.dart';
import '../../../project/presentation/pages/homepage.dart';
import '../bloc/auth_bloc.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';

class AuthenticatePage extends StatelessWidget {
  final Either<SignInPage, SignUpPage> child;

  const AuthenticatePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String successMessage;
    late Widget body;

    child.fold(
      (signIn) {
        successMessage = "Logged In";
        body = const SignInPage();
      },
      (signUp) {
        successMessage = "Account Created";
        body = const SignUpPage();
      },
    );
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is AuthLoading) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 20),
                    Text(authState.message),
                  ],
                ),
                // backgroundColor: Theme.of(context).colorScheme.,
              ),
            );
        } else if (authState is AuthError) {
          // Show error message if the user has entered invalid credentials
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(authState.error),
              ),
            );
        } else if (authState is Authenticated) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(successMessage),
              ),
            );
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      builder: (context, authState) {
        if (authState is Authenticated) {
          // set body to SignInPage so that user will redirect to SignInPage on logout event
          body = const SignInPage();
          successMessage = "Logged In";
          return HomePage(user: authState.user);
        }
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              ThemeModeIconButton(
                lightThemeColor: body is SignUpPage
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
            ],
          ),
          body: body,
        );
      },
    );
  }
}
