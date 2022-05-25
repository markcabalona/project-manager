// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/features/auth/domain/usecases/send_email_otp.dart';
import 'package:todo/features/auth/domain/usecases/validate_email_otp.dart';

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
  final SendEmailOTP sendEmailOTP;
  final ValidateEmailOTP validateEmailOTP;
  AuthBloc({
    required this.signIn,
    required this.signUp,
    required this.googleSignIn,
    required this.signOut,
    required this.sendEmailOTP,
    required this.validateEmailOTP,
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
          AccountCreated(user: user),
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

    on<SendEmailOTPEvent>((event, emit) async {
      final latestState = state;
      emit(AuthLoading(message: "Sending OTP to ${event.user.email}."));
      final result = await sendEmailOTP(EmailOTPParams(user: event.user));

      result.fold(
        (failure) {
          event.user.delete();
          emit(AuthError(error: failure.message));
          emit(UnAuthenticated());
        },
        (user) {
          if (latestState is! EmailOTPSent) {
            emit(EmailOTPSent(user: user));
          }
        },
      );
    });

    on<ValidateEmailOTPEvent>((event, emit) async {
      emit(const AuthLoading(message: "Verifying OTP."));
      final result = await validateEmailOTP(
          EmailOTPParams(user: event.user, otp: event.otp));

      result.fold(
        (failure) {
          event.user.delete();
          emit(AuthError(error: failure.message));
          emit(UnAuthenticated());
        },
        (user) {
          emit(
            Authenticated(user: user),
          );
        },
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
