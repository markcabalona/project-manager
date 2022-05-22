// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/project.dart';
import '../../domain/usecases/create_project.dart';
import '../../domain/usecases/delete_project.dart';
import '../../domain/usecases/fetch_projects.dart';
import '../../domain/usecases/update_project.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final CreateProject createProject;
  final FetchProjects fetchProjects;
  final UpdateProject updateProject;
  final DeleteProject deleteProject;

  ProjectBloc({
    required this.createProject,
    required this.fetchProjects,
    required this.updateProject,
    required this.deleteProject,
  }) : super(LoadingProject()) {
    on<CreateProjectEvent>((event, emit) async {
      final proj = (state as ProjectsLoaded).projects;

      final result = await createProject(event.newProj);

      result.fold(
        (failure) {
          emit(ProjectError(errorMessage: failure.message));
          emit(ProjectsLoaded(projects: proj));
        },
        (project) {
          emit(ProjectCreated(newProject: project));
          emit(ProjectsLoaded(projects: proj..add(project)));
        },
      );
    });

    on<FetchProjectsEvent>((event, emit) async {
      emit(LoadingProject());
      final result = await fetchProjects(null);
      result.fold(
        (failure) {
          emit(ProjectError(errorMessage: failure.message));
          emit(const ProjectsLoaded(projects: []));
        },
        (projects) {
          emit(ProjectsLoaded(projects: projects));
        },
      );
    });

    on<UpdateProjectEvent>((event, emit) async {
      final proj = (state as ProjectsLoaded).projects;

      final result = await updateProject(event.project);

      result.fold(
        (failure) {
          emit(ProjectError(errorMessage: failure.message));
          emit(ProjectsLoaded(projects: proj));
        },
        (project) {
          proj[proj.indexOf(event.project)] = project;
          emit(ProjectUpdated(updatedProject: project));
          emit(ProjectsLoaded(projects: proj));
        },
      );
    });

    on<DeleteProjectEvent>((event, emit) async {
      final proj = (state as ProjectsLoaded).projects;

      final result = await deleteProject(event.params);

      result.fold(
        (failure) {
          emit(ProjectError(errorMessage: failure.message));
          emit(ProjectsLoaded(projects: proj));
        },
        (_) {
          emit(ProjectDeleted());
          emit(
            ProjectsLoaded(
              projects: proj
                ..removeWhere(
                  (element) => element.id == event.params.projectId,
                ),
            ),
          );
        },
      );
    });
  }
}
