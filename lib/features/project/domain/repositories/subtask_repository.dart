import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/subtask.dart';
import '../usecases/create_subtask.dart';

abstract class SubtaskRepository {
  Future<Either<Failure, Subtask>> createSubtask(
    CreateSubtaskParams newSubtask,
  );
  Future<Either<Failure, List<Subtask>>> fetchSubtasks(String projectId);
  Future<Either<Failure, Subtask>> updateSubtask(Subtask subtask);
  Future<Either<Failure, void>> deleteSubtask(String subtaskid);
}
