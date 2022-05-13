import '../../../../core/domain/entities/task.dart';

class Todo extends Task {
  String subtaskId;
  Todo({
    required String todoId,
    required String todoTitle,
    required String content,
    required bool isPriority,
    required DateTime timeCreated,
    required DateTime lastUpdated,
    required bool isFinished,
    required this.subtaskId,
  }) : super(
          id: todoId,
          title: todoTitle,
          content: content,
          isPriority: isPriority,
          dateCreated: timeCreated,
          lastUpdated: lastUpdated,
          isFinished: isFinished,
        );
}
