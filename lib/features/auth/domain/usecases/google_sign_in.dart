import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class GoogleSignIn implements Usecase<User, void> {
  final AuthRepository repository;
  GoogleSignIn({
    required this.repository,
  });
  @override
  Future<Either<Failure, User>> call(_) {
    return repository.googleSignIn();
  }
}
