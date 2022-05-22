import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';
import 'send_email_otp.dart';

class ValidateEmailOTP implements Usecase<User, EmailOTPParams> {
  final AuthRepository repository;
  ValidateEmailOTP({
    required this.repository,
  });
  @override
  Future<Either<Failure, User>> call(emailOtpParams) {
    return repository.validateEmailOTP(emailOtpParams);
  }
}
