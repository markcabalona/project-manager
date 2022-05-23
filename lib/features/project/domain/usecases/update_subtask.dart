import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/subtask.dart';
import '../repositories/subtask_repository.dart';

class UpdateSubtask implements Usecase<Subtask, Subtask> {
  final SubtaskRepository repository;
  UpdateSubtask({
    required this.repository,
  });
  @override
  Future<Either<Failure, Subtask>> call(subtask) {
    return repository.updateSubtask(subtask);
  }
}
