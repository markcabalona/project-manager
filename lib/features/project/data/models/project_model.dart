import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/project.dart';

class ProjectModel extends Project {
  ProjectModel({
    String? projectId,
    required String projectTitle,
    required String description,
    required bool isPriority,
    DateTime? dateCreated,
    DateTime? lastUpdated,
    bool? isFinished,
  }) : super(
          projectId: projectId ?? '',
          projectTitle: projectTitle,
          description: description,
          isPriority: isPriority,
          dateCreated: dateCreated ?? DateTime.now(),
          lastUpdated: lastUpdated ?? DateTime.now(),
          isFinished: isFinished ?? false,
        );

  Map<String, dynamic> toMap() => {
        'project_title': title,
        'project_desc': description,
        'is_finished': isFinished,
        'is_priority': isPriority,
        'date_created': dateCreated,
        'last_updated': DateTime.now(),
      };

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    
    return ProjectModel(
      projectId: map['proj_id'],
      description: map['project_desc'] ?? 'Project Description',
      isFinished: map['is_finished'] ?? false,
      isPriority: map['is_priority'] ?? false,
      dateCreated: (map['date_created'] as Timestamp).toDate(),
      projectTitle: map['project_title'] ?? 'Untitled Project',
      lastUpdated: (map['last_updated'] as Timestamp).toDate(),
    );
  }
}
