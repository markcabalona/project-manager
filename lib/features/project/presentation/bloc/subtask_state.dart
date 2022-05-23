part of 'subtask_bloc.dart';

abstract class SubtaskState extends Equatable {
  const SubtaskState();
  
  @override
  List<Object> get props => [];
}

class SubtaskInitial extends SubtaskState {}
