// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
  }) : super(SubtaskInitial()) {
    on<SubtaskEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
