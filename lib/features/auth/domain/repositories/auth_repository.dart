import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/domain/usecases/usecase_params.dart';
import '../../../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signIn(AuthParams params);
  Future<Either<Failure, User>> signUp(AuthParams params);
  Future<Either<Failure, User>> googleSignIn();
  Future<Either<Failure,void>> signOut();
}
