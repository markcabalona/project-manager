import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, Todo>> createTodo();
  Future<Either<Failure, List<Todo>>> fetchTodos();
  Future<Either<Failure, Todo>> updateTodo();
  Future<Either<Failure, void>> deleteTodo();
}
