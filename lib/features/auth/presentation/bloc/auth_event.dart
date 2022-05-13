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

class CheckAuthStateEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
