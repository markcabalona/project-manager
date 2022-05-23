import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/subtask.dart';
import '../repositories/subtask_repository.dart';

class CreateSubtask implements Usecase<Subtask, CreateSubtaskParams> {
  final SubtaskRepository repository;
  CreateSubtask({
    required this.repository,
  });
  @override
  Future<Either<Failure, Subtask>> call(CreateSubtaskParams newSubtask) {
    return repository.createSubtask(newSubtask);
  }
}

class CreateSubtaskParams {
  final String projectId;
  final String title;
  final String description;
  final bool isPriority;
  const CreateSubtaskParams({
    required this.projectId,
    required this.title,
    required this.description,
    required this.isPriority,
  });
}
