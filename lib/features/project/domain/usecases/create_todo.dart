import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class CreateTodo implements Usecase<Todo, CreateTodoParams> {
  final TodoRepository repository;
  CreateTodo({
    required this.repository,
  });
  @override
  Future<Either<Failure, Todo>> call(CreateTodoParams params) {
    return repository.createTodo();
  }
}

class CreateTodoParams {
  final String title;
  final String content;
  final bool isPriority;
  CreateTodoParams({
    required this.title,
    required this.content,
    required this.isPriority,
  });
}
