import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/subtask.dart';

abstract class SubtaskRepository {
  Future<Either<Failure, Subtask>> createSubtask();
  Future<Either<Failure, List<Subtask>>> fetchSubtasks();
  Future<Either<Failure, Subtask>> updateSubtask();
  Future<Either<Failure, void>> deleteSubtask();
}
