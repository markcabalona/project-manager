import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/project_repository.dart';

class DeleteProject implements Usecase<void, DeleteProjectParams> {
  final ProjectRepository repository;
  DeleteProject({
    required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(DeleteProjectParams params) {
    return repository.deleteProject(params.projectId);
  }
}

class DeleteProjectParams {
  final String projectId;
  const DeleteProjectParams({
    required this.projectId,
  });
}
