import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/subtask.dart';
import '../repositories/subtask_repository.dart';

class FetchSubtasks implements Usecase<List<Subtask>, String> {
  final SubtaskRepository repository;
  FetchSubtasks({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<Subtask>>> call(projectId) {
    return repository.fetchSubtasks(projectId);
  }
}
