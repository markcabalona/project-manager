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

  Project copyWith({
    String? projectId,
    String? title,
    String? description,
    bool? isPriority,
    DateTime? dateCreated,
    DateTime? lastUpdated,
    bool? isFinished,
  }) {
    return Project(
      projectId: projectId ?? id,
      projectTitle: title ?? this.title,
      description: description ?? this.description,
      isPriority: isPriority ?? this.isPriority,
      dateCreated: dateCreated ?? this.dateCreated,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isFinished: isFinished ?? this.isFinished,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Project && other.id == id;
  }

  @override
  int get hashCode => description.hashCode;
}
