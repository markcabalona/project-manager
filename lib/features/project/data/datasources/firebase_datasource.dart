import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/project.dart';
import '../../domain/usecases/create_project.dart';
import '../models/project_model.dart';
import 'remote_datasource.dart';

class FirebaseDatasource implements RemoteDatasource {
  final FirebaseAuth _firebaseAuthInstance = FirebaseAuth.instance;
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  @override
  Future<Project> createProject(CreateProjectParams newProj) async {
    final result = await _instance.collection('/projects').add(
          ProjectModel(
            description: newProj.description.isEmpty?'No Description':newProj.description,
            isPriority: newProj.isPriority,
            projectTitle: newProj.title.isEmpty?'Untitled':newProj.title,
          ).toMap()
            ..addEntries(
                {'user_id': _firebaseAuthInstance.currentUser!.uid}.entries),
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
      log(_firebaseAuthInstance.currentUser!.uid);
      final result = await _instance
          .collection('/projects')
          .where(
            'user_id',
            isEqualTo: _firebaseAuthInstance.currentUser!.uid,
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
                {'user_id': _firebaseAuthInstance.currentUser!.uid}.entries,
              ),
          );

      return _instance.collection('/projects').doc(proj.id).get().then((value) {
        if (value.data() == null) {
          throw const ServerException(message: "Failed to create Project");
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
}
