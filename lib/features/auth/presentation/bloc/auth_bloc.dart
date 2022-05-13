import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/domain/usecases/usecase_params.dart';
import '../../domain/usecases/google_sign_in.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn signIn;
  final SignUp signUp;
  final GoogleSignIn googleSignIn;
  final SignOut signOut;
  AuthBloc({
    required this.signIn,
    required this.signUp,
    required this.googleSignIn,
    required this.signOut,
  }) : super(UnAuthenticated()) {
    on<SignInEvent>((event, emit) async {
      emit(const AuthLoading(
        message: 'Logging In',
      ));
      final result = await signIn(event.params);

      result.fold(
        (failure) {
          emit(
            AuthError(error: failure.message),
          );
          emit(UnAuthenticated());
        },
        (user) => emit(
          Authenticated(user: user),
        ),
      );
    });

    on<SignUpEvent>((event, emit) async {
      emit(const AuthLoading(message: 'Creating Account'));
      final result = await signUp(event.params);
      result.fold(
        (failure) {
          emit(
            AuthError(error: failure.message),
          );
          emit(UnAuthenticated());
        },
        (user) => emit(
          Authenticated(user: user),
        ),
      );
    });

    on<GoogleSignInEvent>((event, emit) async {
      emit(const AuthLoading(
        message: 'Signing In',
      ));
      final result = await googleSignIn(null);
      result.fold(
        (failure) => emit(
          AuthError(error: failure.message),
        ),
        (user) => emit(
          Authenticated(user: user),
        ),
      );
    });

    on<SignOutEvent>((event, emit) async {
      emit(const AuthLoading(
        message: 'Signing Out',
      ));
      final result = await signOut(null);

      result.fold(
        (failure) => emit(AuthError(error: failure.message)),
        (_) => emit(UnAuthenticated()),
      );
    });
  }
}
