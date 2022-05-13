import '../../../../core/domain/entities/task.dart';

class Project extends Task {
  String description;

  Project({
    required String projectId,
    required String projectTitle,
    required this.description,
    required bool isPriority,
    required DateTime dateCreated,
    required DateTime lastUpdated,
    required bool isFinished,
  }) : super(
          id: projectId,
          title: projectTitle,
          content: description,
          isPriority: isPriority,
          dateCreated: dateCreated,
          lastUpdated: lastUpdated,
          isFinished: isFinished,
        );
}
