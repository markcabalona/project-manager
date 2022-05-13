import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class FetchTodos implements Usecase<List<Todo>, void> {
  final TodoRepository repository;
  FetchTodos({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<Todo>>> call(void params) {
    return repository.fetchTodos();
  }
}
