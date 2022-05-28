import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/login_info.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/subtask.dart';
import '../../domain/usecases/create_project.dart';
import '../../domain/usecases/create_subtask.dart';
import '../models/project_model.dart';
import '../models/subtask_model.dart';
import 'remote_datasource.dart';

class FirebaseDatasource implements RemoteDatasource {
  final LoginInfo loginInfo = LoginInfo.instance;
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  @override
  Future<Project> createProject(CreateProjectParams newProj) async {
    final result = await _instance.collection('/projects').add(
          ProjectModel(
            description: newProj.description.isEmpty
                ? 'No Description'
                : newProj.description,
            isPriority: newProj.isPriority,
            projectTitle: newProj.title.isEmpty ? 'Untitled' : newProj.title,
          ).toMap()
            ..addEntries({'user_id': loginInfo.currentUID}.entries),
        );

    return result.get().then((value) {
      if (value.data() == null) {
        throw const ServerException(message: "Failed to create Project");
      }
      return ProjectModel.fromMap(
        value.data()!
          ..addEntries(
            {'proj_id': value.id}.entries,
          ),
      );
    });
  }

  @override
  Future<void> deleteProject(String projId) async {
    try {
      return await _instance.collection('/projects').doc(projId).delete();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<Project>> fetchProjects() async {
    try {
      log(loginInfo.currentUID!);
      final result = await _instance
          .collection('/projects')
          .where(
            'user_id',
            isEqualTo: loginInfo.currentUID,
          )
          .orderBy(
            'is_priority',
            descending: false,
          )
          .get();

      return result.docs
          .map(
            (doc) => ProjectModel.fromMap(
              doc.data()
                ..addEntries(
                  {'proj_id': doc.id}.entries,
                ),
            ),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Project> updateProject(Project proj) async {
    try {
      await _instance.collection('/projects').doc(proj.id).update(
            ProjectModel(
              projectTitle: proj.title,
              description: proj.description,
              isPriority: proj.isPriority,
              dateCreated: proj.dateCreated,
              isFinished: proj.isFinished,
              lastUpdated: proj.lastUpdated,
            ).toMap()
              ..addEntries(
                {'user_id': loginInfo.currentUID}.entries,
              ),
          );

      return _instance.collection('/projects').doc(proj.id).get().then((value) {
        if (value.data() == null) {
          throw const ServerException(message: "Failed to update Project");
        }
        return ProjectModel.fromMap(
          value.data()!
            ..addEntries(
              {'proj_id': proj.id}.entries,
            ),
        );
      });
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Subtask> createSubtask(CreateSubtaskParams newSubtask) async {
    final result = await _instance.collection('/subtasks/').add(
          SubtaskModel(
            projectId: newSubtask.projectId,
            description: newSubtask.description.isEmpty
                ? 'No Description'
                : newSubtask.description,
            isPriority: newSubtask.isPriority,
            subtaskTitle:
                newSubtask.title.isEmpty ? 'Untitled' : newSubtask.title,
          ).toMap(),
        );

    return result.get().then((value) {
      if (value.data() == null) {
        throw const ServerException(message: "Failed to create Subtask");
      }
      return SubtaskModel.fromMap(
        value.data()!
          ..addEntries(
            {'subtask_id': value.id}.entries,
          ),
      );
    });
  }

  @override
  Future<void> deleteSubtask(String subtaskId) async {
    try {
      return await _instance.collection('/subtasks').doc(subtaskId).delete();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<Subtask>> fetchSubtasks(String projectId) async {
    try {
      final result = await _instance
          .collection('/subtasks')
          .where(
            'project_id',
            isEqualTo: projectId,
          )
          .orderBy(
            'is_priority',
            descending: false,
          )
          .get();

      return result.docs
          .map(
            (doc) => SubtaskModel.fromMap(
              doc.data()
                ..addEntries(
                  {'subtask_id': doc.id}.entries,
                ),
            ),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Subtask> updateSubtask(Subtask subtask) async {
    try {
      await _instance.collection('/subtasks').doc(subtask.id).update(
            ProjectModel(
                    projectTitle: subtask.title,
                    description: subtask.description,
                    isPriority: subtask.isPriority,
                    dateCreated: subtask.dateCreated,
                    isFinished: subtask.isFinished,
                    lastUpdated: subtask.lastUpdated,
                    projectId: subtask.id)
                .toMap(),
          );

      return _instance
          .collection('/subtasks')
          .doc(subtask.id)
          .get()
          .then((value) {
        if (value.data() == null) {
          throw const ServerException(message: "Failed to update subtask");
        }
        return SubtaskModel.fromMap(
          value.data()!
            ..addEntries(
              {'subtask_id': subtask.id}.entries,
            ),
        );
      });
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
