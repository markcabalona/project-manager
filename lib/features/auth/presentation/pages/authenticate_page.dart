import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
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
    late String _successMessage;
    late Widget _child;

    child.fold(
      (signIn) {
        _successMessage = "Logged In";
        _child = const SignInPage();
      },
      (signUp) {
        _successMessage = "Account Created";
        _child = const SignUpPage();
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
                      child: CircularProgressIndicator(strokeWidth: 2),
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 20),
                    Text(authState.message),
                  ],
                ),
                backgroundColor: kAccentColor,
              ),
            );
        } else if (authState is AuthError) {
          // Show error message if the user has entered invalid credentials
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(authState.error),
                backgroundColor: kAccentColor,
              ),
            );
        } else if (authState is Authenticated) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(_successMessage),
                backgroundColor: kAccentColor,
              ),
            );
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      builder: (context, authState) {
        if (authState is Authenticated) {
          // set _child to SignInPage so that user will redirect to SignInPage on logout event
          _child = const SignInPage();
          _successMessage = "Logged In";
          BlocProvider.of<ProjectBloc>(context).add(FetchProjectsEvent());
          return HomePage(user: authState.user);
        }
        return _child;
      },
    );
  }
}
