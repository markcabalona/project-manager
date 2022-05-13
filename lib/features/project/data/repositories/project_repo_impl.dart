import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';
import '../../domain/usecases/create_project.dart';
import '../datasources/remote_datasource.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final RemoteDatasource remoteDatasource;
  ProjectRepositoryImpl({
    required this.remoteDatasource,
  });
  @override
  Future<Either<Failure, Project>> createProject(
      CreateProjectParams newProj) async {
    try {
      return Right(
        await remoteDatasource.createProject(newProj),
      );
    } on ServerException catch (exception) {
      return Left(
        ServerFailure(message: exception.message ?? "Project Creation Failed."),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(String projId) async {
    try {
      return Right(
        await remoteDatasource.deleteProject(projId),
      );
    } on ServerException catch (exception) {
      return Left(
        ServerFailure(message: exception.message ?? "Project Deletion Failed."),
      );
    }
  }

  @override
  Future<Either<Failure, List<Project>>> fetchProjects() async {
    try {
      return Right(
        await remoteDatasource.fetchProjects(),
      );
    } on ServerException catch (exception) {
      return Left(
        ServerFailure(
            message: exception.message ?? "Fetching Projects Failed."),
      );
    }
  }

  @override
  Future<Either<Failure, Project>> updateProject(Project proj) async {
    try {
      return Right(
        await remoteDatasource.updateProject(proj),
      );
    } on ServerException catch (exception) {
      return Left(
        ServerFailure(message: exception.message ?? "Project Update Failed."),
      );
    }
  }
}
