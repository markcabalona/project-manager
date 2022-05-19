import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/project.dart';
import '../repositories/project_repository.dart';

class CreateProject implements Usecase<Project, CreateProjectParams> {
  final ProjectRepository repository;
  CreateProject({
    required this.repository,
  });
  @override
  Future<Either<Failure, Project>> call(CreateProjectParams params) {
    return repository.createProject(params);
  }
}

class CreateProjectParams {
  final String title;
  final String description;
  final bool isPriority;
  const CreateProjectParams({
    required this.title,
    required this.description,
    required this.isPriority,
  });
}
