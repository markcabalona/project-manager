import '../../../../core/domain/entities/task.dart';

class Subtask extends Task {
  String projectId;
  String description;
  Subtask({
    required String subtaskId,
    required String subtaskTitle,
    required this.description,
    required bool isPriority,
    required DateTime dateCreated,
    required DateTime lastUpdated,
    required bool isFinished,
    required this.projectId,
  }) : super(
          id: subtaskId,
          title: subtaskTitle,
          content: description,
          isPriority: isPriority,
          dateCreated: dateCreated,
          lastUpdated: lastUpdated,
          isFinished: isFinished,
        );

  Subtask copyWith({
    String? projectId,
    String? subtaskId,
    String? subtaskTitle,
    String? description,
    bool? isPriority,
    DateTime? dateCreated,
    DateTime? lastUpdated,
    bool? isFinished,
  }) {
    return Subtask(
      projectId: projectId ?? this.projectId,
      subtaskId: subtaskId ?? id,
      subtaskTitle: subtaskTitle ?? title,
      description: description ?? this.description,
      isFinished: isFinished ?? this.isFinished,
      isPriority: isPriority ?? this.isPriority,
      dateCreated: dateCreated ?? this.dateCreated,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Subtask && other.id == id;
  }

  @override
  int get hashCode => projectId.hashCode;
}
