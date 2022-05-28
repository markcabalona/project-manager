// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/features/project/domain/entities/subtask.dart';

import '../../domain/usecases/create_subtask.dart';
import '../../domain/usecases/delete_subtask.dart';
import '../../domain/usecases/fetch_subtasks.dart';
import '../../domain/usecases/update_subtask.dart';

part 'subtask_event.dart';
part 'subtask_state.dart';

class SubtaskBloc extends Bloc<SubtaskEvent, SubtaskState> {
  final CreateSubtask createSubtask;
  final FetchSubtasks fetchSubtasks;
  final UpdateSubtask updateSubtask;
  final DeleteSubtask deleteSubtask;
  SubtaskBloc({
    required this.createSubtask,
    required this.fetchSubtasks,
    required this.updateSubtask,
    required this.deleteSubtask,
  }) : super(FetchingSubtasks()) {
    on<FetchSubtasksEvent>(
      (event, emit) async {
        emit(FetchingSubtasks());

        final result = await fetchSubtasks(event.projectId);

        result.fold(
          (failure) {
            emit(SubtaskError(errorMessage: failure.message));
            emit(const SubtasksLoaded(subtasks: []));
          },
          (subtasks) {
            emit(SubtasksLoaded(subtasks: subtasks));
          },
        );
      },
    );

    on<CreateSubtaskEvent>(
      (event, emit) async {
        final subtasks = (state as SubtasksLoaded).subtasks;

        emit(CreatingSubtask());
        final result = await createSubtask(event.newSubtask);

        result.fold(
          (failure) {
            emit(SubtaskError(errorMessage: failure.message));
            emit(const SubtasksLoaded(subtasks: []));
          },
          (subtask) {
            emit(SubtaskCreated(subtask: subtask));
            emit(SubtasksLoaded(subtasks: subtasks..add(subtask)));
          },
        );
      },
    );
  }
}
