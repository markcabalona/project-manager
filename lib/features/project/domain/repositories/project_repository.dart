import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/project.dart';
import '../usecases/create_project.dart';

abstract class ProjectRepository {
  Future<Either<Failure, Project>> createProject(
    CreateProjectParams newProject,
  );
  Future<Either<Failure, List<Project>>> fetchProjects();
  Future<Either<Failure, Project>> updateProject(Project proj);
  Future<Either<Failure, void>> deleteProject(String projId);
}
