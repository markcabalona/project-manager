part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  final String message;
  const AuthLoading({
    required this.message,
  });
  @override
  List<Object> get props => super.props..add(message);
}

// initial state
class UnAuthenticated extends AuthState {}

class Authenticated extends AuthState {
  final User user;
  const Authenticated({
    required this.user,
  });
  @override
  List<Object> get props => super.props..add(user);
}

class AccountCreated extends AuthState {
  final User user;
  const AccountCreated({
    required this.user,
  });

  @override
  List<Object> get props => super.props..add(user);
}

class EmailOTPSent extends AuthState {
  final User user;
  const EmailOTPSent({
    required this.user,
  });
  @override
  List<Object> get props => super.props..add(user);
}



class AuthError extends AuthState {
  final String error;

  const AuthError({required this.error});
  @override
  List<Object> get props => super.props..add(error);
}
