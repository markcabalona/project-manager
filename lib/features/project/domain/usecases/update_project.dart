import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/project.dart';
import '../repositories/project_repository.dart';

class UpdateProject implements Usecase<Project, Project> {
  final ProjectRepository repository;
  UpdateProject({
    required this.repository,
  });
  @override
  Future<Either<Failure, Project>> call(Project params) {
    return repository.updateProject(params);
  }
}
