part of 'subtask_bloc.dart';

abstract class SubtaskState extends Equatable {
  const SubtaskState();

  @override
  List<Object> get props => [];
}

class FetchingSubtasks extends SubtaskState {}

class SubtasksLoaded extends SubtaskState {
  final List<Subtask> subtasks;
  const SubtasksLoaded({
    required this.subtasks,
  });

  @override
  List<Object> get props => super.props..add(subtasks);
}

class SubtaskError extends SubtaskState {
  final String errorMessage;
  const SubtaskError({
    required this.errorMessage,
  });
  @override
  List<Object> get props => super.props..add(errorMessage);
}
