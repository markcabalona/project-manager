part of 'project_bloc.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class CreateProjectEvent extends ProjectEvent {
  final CreateProjectParams newProj;
  const CreateProjectEvent({
    required this.newProj,
  });

  @override
  List<Object> get props => super.props..add(newProj);
}

class FetchProjectsEvent extends ProjectEvent {}

class UpdateProjectEvent extends ProjectEvent {
  final Project project;
  const UpdateProjectEvent({
    required this.project,
  });
  @override
  List<Object> get props => super.props..add(project);
}

class DeleteProjectEvent extends ProjectEvent {
  final DeleteProjectParams params;
  const DeleteProjectEvent({
    required this.params,
  });

  @override
  List<Object> get props => super.props..add(params);
}
