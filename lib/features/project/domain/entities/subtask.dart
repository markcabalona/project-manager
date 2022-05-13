import '../../../../core/domain/entities/task.dart';

class Subtask extends Task {
  String projectId;
  Subtask({
    required String subtaskId,
    required String subtaskTitle,
    required String description,
    required bool isPriority,
    required DateTime timeCreated,
    required DateTime lastUpdated,
    required bool isFinished,
    required this.projectId,
  }) : super(
          id: subtaskId,
          title: subtaskTitle,
          content: description,
          isPriority: isPriority,
          dateCreated: timeCreated,
          lastUpdated: lastUpdated,
          isFinished: isFinished,
        );
}
