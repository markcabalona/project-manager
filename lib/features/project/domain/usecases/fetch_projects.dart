import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/project.dart';
import '../repositories/project_repository.dart';

class FetchProjects implements Usecase<List<Project>, void> {
  final ProjectRepository repository;
  FetchProjects({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<Project>>> call(void params) {
    return repository.fetchProjects();
  }
}
