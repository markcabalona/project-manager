import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class SendEmailOTP implements Usecase<User, EmailOTPParams> {
  final AuthRepository repository;
  SendEmailOTP({
    required this.repository,
  });
  @override
  Future<Either<Failure, User>> call(emailOTPParams) {
    return repository.sendEmailOTP(emailOTPParams);
  }
}

class EmailOTPParams {
  final User user;
  final String? otp;
  const EmailOTPParams({
    required this.user,
    this.otp,
  });
}
