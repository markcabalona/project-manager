import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/subtask_repository.dart';

class DeleteSubtask implements Usecase<void, String> {
  final SubtaskRepository repository;
  DeleteSubtask({
    required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(subtaskId) {
    return repository.deleteSubtask(subtaskId);
  }
}
