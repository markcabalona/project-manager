import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/todo_repository.dart';

class DeleteTodo implements Usecase<void, DeleteTodoParams> {
  final TodoRepository repository;
  DeleteTodo({
    required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(DeleteTodoParams params) {
    return repository.deleteTodo();
  }
}

class DeleteTodoParams {
  final String todoId;
  const DeleteTodoParams({
    required this.todoId,
  });
}
