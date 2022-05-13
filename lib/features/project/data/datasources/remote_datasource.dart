import '../../domain/entities/project.dart';
import '../../domain/usecases/create_project.dart';

abstract class RemoteDatasource {
  Future<Project> createProject(CreateProjectParams newProj);
  Future<List<Project>> fetchProjects();
  Future<Project> updateProject(Project proj);
  Future<void> deleteProject(String projId);
}