import 'package:to_do/data/repositories/todo_repository.dart';

import '../../models/todo.dart';
import '../local/todo_db_service.dart';
import '../remote/todo_firestore_service.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDbService _todoDbService;
  final TodoFirestoreService _todoFirestoreService;

  TodoRepositoryImpl({TodoDbService? todoDbService, TodoFirestoreService? todoFirestoreService})
      : _todoDbService = todoDbService ?? TodoDbService(),
        _todoFirestoreService = todoFirestoreService ?? TodoFirestoreService();

  @override
  Future<List<Todo>> getAllTodos() async {
    return _todoFirestoreService.getTodos().catchError((e) => _todoDbService.getTodos()).then((value) => value);
  }

  @override
  Future<void> addTodo(Todo todo) async {
    _todoFirestoreService.addTodo(todo).catchError((error) {
      _todoDbService.addTodo(todo);
    }).then((value) => value);
  }

  @override
  Future<void> deleteAllTodos() async {
    _todoDbService.deleteAllTodos().catchError((e) {
      print("add local database err :: ${e}");
    });
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    _todoFirestoreService.deleteTodo(todo).catchError((e){
      _todoDbService.deleteTodo(todo);
    }).then((value) => print("todo Deleted"),);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    _todoFirestoreService.updateTodo(todo).catchError((e){
      _todoDbService.updateTodo(todo);
    }).then((value) => print("todo Updated"),);
  }
}
