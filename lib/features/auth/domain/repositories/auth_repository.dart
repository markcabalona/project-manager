import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/domain/usecases/usecase_params.dart';
import '../../../../core/errors/failures.dart';
import '../usecases/send_email_otp.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signIn(AuthParams params);
  Future<Either<Failure, User>> signUp(AuthParams params);
  Future<Either<Failure, User>> googleSignIn();
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, User>> sendEmailOTP(EmailOTPParams emailOTPParams);
  Future<Either<Failure, User>> validateEmailOTP(EmailOTPParams emailOTPParams);
}
