part of 'subtask_bloc.dart';

abstract class SubtaskEvent extends Equatable {
  const SubtaskEvent();

  @override
  List<Object> get props => [];
}

class FetchSubtasksEvent extends SubtaskEvent {
  final String projectId;
  const FetchSubtasksEvent({
    required this.projectId,
  });

  @override
  List<Object> get props => super.props..add(projectId);
}

class CreateSubtaskEvent extends SubtaskEvent {
  final CreateSubtaskParams newSubtask;
  const CreateSubtaskEvent({
    required this.newSubtask,
  });

  @override
  List<Object> get props => super.props..add(newSubtask);
}

class UpdateSubtaskEvent extends SubtaskEvent {
  final Subtask subtask;
  const UpdateSubtaskEvent({
    required this.subtask,
  });

  @override
  List<Object> get props => super.props..add(subtask);
}

class DeleteSubtaskEvent extends SubtaskEvent {
  final String subtaskID;
  const DeleteSubtaskEvent({
    required this.subtaskID,
  });

  @override
  List<Object> get props => super.props..add(subtaskID);
}
