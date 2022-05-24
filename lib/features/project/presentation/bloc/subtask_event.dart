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
