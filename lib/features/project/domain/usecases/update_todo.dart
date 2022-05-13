import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class UpdateTodo implements Usecase<Todo, UpdateTodoParams> {
  final TodoRepository repository;
  UpdateTodo({
    required this.repository,
  });
  @override
  Future<Either<Failure, Todo>> call(UpdateTodoParams params) {
    return repository.updateTodo();
  }
}

class UpdateTodoParams {
  final Todo todo;
  UpdateTodoParams({
    required this.todo,
  });
}
