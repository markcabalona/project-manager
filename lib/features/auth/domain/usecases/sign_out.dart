import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class SignOut implements Usecase<void, void> {
  final AuthRepository repository;
  SignOut({
    required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(void params) {
    return repository.signOut();
  }
}
