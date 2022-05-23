import '../../domain/entities/project.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/usecases/create_project.dart';
import '../../domain/usecases/create_subtask.dart';

abstract class RemoteDatasource {
  Future<Project> createProject(CreateProjectParams newProj);
  Future<List<Project>> fetchProjects();
  Future<Project> updateProject(Project proj);
  Future<void> deleteProject(String projId);

  Future<Subtask> createSubtask(CreateSubtaskParams newSubtask);
  Future<List<Subtask>> fetchSubtasks(String projectId);
  Future<Subtask> updateSubtask(Subtask subtask);
  Future<void> deleteSubtask(String subtaskId);
}
