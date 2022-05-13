part of 'project_bloc.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object> get props => [];
}

class LoadingProject extends ProjectState {}

class ProjectCreated extends ProjectState {
  final Project newProject;
  const ProjectCreated({
    required this.newProject,
  });

  @override
  List<Object> get props => super.props..add(newProject);
}

class ProjectsLoaded extends ProjectState {
  final List<Project> projects;
  const ProjectsLoaded({
    required this.projects,
  });

  @override
  List<Object> get props => super.props..add(projects);
}

class ProjectUpdated extends ProjectState {
  final Project updatedProject;
  const ProjectUpdated({
    required this.updatedProject,
  });

  @override
  List<Object> get props => super.props..add(updatedProject);
}

class ProjectDeleted extends ProjectState {}

class ProjectError extends ProjectState {
  final String errorMessage;
  const ProjectError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => super.props..add(errorMessage);
}
