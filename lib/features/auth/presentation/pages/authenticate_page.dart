import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/presentation/routes/routes.dart';

import '../../../../core/presentation/widgets/theme_mode_iconbutton.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is EmailOTPSent) {
          context.goNamed(Routes.otp.name, extra: authState.user);
        }
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
                      child: RepaintBoundary(
                          child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        authState.message,
                        maxLines: 3,
                      ),
                    ),
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
                content: Text(
                  authState.error,
                  maxLines: 3,
                ),
              ),
            );
        } else if (authState is AccountCreated) {
          BlocProvider.of<AuthBloc>(context).add(
            SendEmailOTPEvent(user: authState.user),
          );
        } else if (authState is Authenticated) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(successMessage),
              ),
            );
        } else if (authState is UnAuthenticated) {
          context.goNamed(
              (body is SignInPage) ? Routes.login.name : Routes.signUp.name);
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          foregroundColor:
              body is SignUpPage ? Theme.of(context).colorScheme.primary : null,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: const [
            ThemeModeIconButton(),
          ],
        ),
        body: body,
      ),
    );
  }
}
