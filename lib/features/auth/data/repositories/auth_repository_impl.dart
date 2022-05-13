import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/domain/usecases/usecase_params.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/authenticator.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Authenticator authenticator;
  AuthRepositoryImpl({
    required this.authenticator,
  });

  @override
  Future<Either<Failure, User>> googleSignIn() async {
    try {
      return Right(await authenticator.googleSignIn());
    } on AuthException catch (exception) {
      return Left(
        AuthFailure(
          message: exception.message ?? "Google Sign In failed.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, User>> signIn(AuthParams params) async {
    try {
      return Right(await authenticator.signIn(params));
    } on AuthException catch (exception) {
      return Left(
        AuthFailure(
          message: exception.message ?? "Sign In failed.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, User>> signUp(AuthParams params) async {
    try {
      return Right(await authenticator.signUp(params));
    } on AuthException catch (exception) {
      return Left(
        AuthFailure(
          message: exception.message ?? "Sign Up failed.",
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      return Right(await authenticator.signOut());
    } on AuthException catch (exception) {
      return Left(AuthFailure(message: exception.message ?? "Sign Out Failed"));
    }
  }
}
