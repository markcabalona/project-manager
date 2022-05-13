import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/domain/usecases/usecase_params.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class SignIn implements Usecase<User, AuthParams> {
  final AuthRepository repository;
  SignIn({
    required this.repository,
  });
  @override
  Future<Either<Failure, User>> call(params) {
    return repository.signIn(params);
  }
}
