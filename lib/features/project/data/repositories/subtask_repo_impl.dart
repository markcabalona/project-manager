import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/repositories/subtask_repository.dart';
import '../../domain/usecases/create_subtask.dart';
import '../datasources/remote_datasource.dart';

class SubtaskRepositoryImpl implements SubtaskRepository {
  final RemoteDatasource remoteDatasource;
  SubtaskRepositoryImpl({
    required this.remoteDatasource,
  });
  @override
  Future<Either<Failure, Subtask>> createSubtask(
      CreateSubtaskParams newSubtask) async {
    try {
      return Right(
        await remoteDatasource.createSubtask(newSubtask),
      );
    } on ServerException catch (exception) {
      return Left(
        ServerFailure(message: exception.message ?? "Subtask Creation Failed."),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteSubtask(
      String subtaskId) async {
    try {
      return Right(
        await remoteDatasource.deleteSubtask(subtaskId),
      );
    } on ServerException catch (exception) {
      return Left(
        ServerFailure(message: exception.message ?? "Subtask Deletion Failed."),
      );
    }
  }

  @override
  Future<Either<Failure, List<Subtask>>> fetchSubtasks(String projectId) async {
    try {
      return Right(
        await remoteDatasource.fetchSubtasks(projectId),
      );
    } on ServerException catch (exception) {
      return Left(
        ServerFailure(
            message: exception.message ?? "Fetching Subtasks Failed."),
      );
    }
  }

  @override
  Future<Either<Failure, Subtask>> updateSubtask(
      Subtask subtask) async {
    try {
      return Right(
        await remoteDatasource.updateSubtask(subtask),
      );
    } on ServerException catch (exception) {
      return Left(
        ServerFailure(message: exception.message ?? "Subtask Update Failed."),
      );
    }
  }
}
