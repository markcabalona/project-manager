part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  final AuthParams params;
  const SignInEvent({
    required this.params,
  });

  @override
  List<Object> get props => super.props..add(params);
}

class SignUpEvent extends AuthEvent {
  final AuthParams params;
  const SignUpEvent({
    required this.params,
  });
  @override
  List<Object> get props => super.props..add(params);
}

class GoogleSignInEvent extends AuthEvent {}

class SendEmailOTPEvent extends AuthEvent {
  final User user;
  const SendEmailOTPEvent({
    required this.user,
  });

  @override
  List<Object> get props => super.props..add(user);
}

class ValidateEmailOTPEvent extends AuthEvent {
  final User user;
  final String otp;
  const ValidateEmailOTPEvent({
    required this.user,
    required this.otp,
  });

  @override
  List<Object> get props => super.props..addAll([user, otp]);
}

class SignOutEvent extends AuthEvent {}
