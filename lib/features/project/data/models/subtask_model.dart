import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/subtask.dart';

class SubtaskModel extends Subtask {
  SubtaskModel({
    required String projectId,
    String? subtaskId,
    required String subtaskTitle,
    required String description,
    required bool isPriority,
    DateTime? dateCreated,
    DateTime? lastUpdated,
    bool? isFinished,
  }) : super(
          projectId: projectId,
          subtaskId: subtaskId ?? '',
          subtaskTitle: subtaskTitle,
          description: description,
          isPriority: isPriority,
          dateCreated: dateCreated ?? DateTime.now(),
          lastUpdated: lastUpdated ?? DateTime.now(),
          isFinished: isFinished ?? false,
        );

  Map<String, dynamic> toMap() => {
        'project_id': projectId,
        'project_title': title,
        'project_desc': content,
        'is_finished': isFinished,
        'is_priority': isPriority,
        'date_created': dateCreated,
        'last_updated': lastUpdated,
      };

  factory SubtaskModel.fromMap(Map<String, dynamic> map) {
    return SubtaskModel(
      projectId: map['project_id'],
      subtaskId: map['subtask_id'],
      description: map['project_desc'] ?? 'Project Description',
      isFinished: map['is_finished'] ?? false,
      isPriority: map['is_priority'] ?? false,
      dateCreated: (map['date_created'] as Timestamp).toDate(),
      subtaskTitle: map['project_title'] ?? 'Untitled Project',
      lastUpdated: (map['last_updated'] as Timestamp).toDate(),
    );
  }
}
