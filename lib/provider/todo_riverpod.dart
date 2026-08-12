import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo {
  final String id;
  final String title;
  final bool isDone;

  Todo({required this.id, required this.title, required this.isDone});
}

Future<List<Todo>> fetchTodos() async {
  await Future.delayed(const Duration(seconds: 1));

  return [
    Todo(id: '1', title: 'Learn Riverpod', isDone: false),
    Todo(id: '2', title: 'Practice Flutter', isDone: false),
    Todo(id: '3', title: 'Build Todo App', isDone: true),
  ];
}

class TodoNotifier extends AsyncNotifier<List<Todo>> {
  @override
  FutureOr<List<Todo>> build() async {
    return fetchTodos();
  }

  void addTodo(String title) {
    final currentTodos = state.value ?? [];

    final newTodo = Todo(
      id: DateTime.now().toString(),
      title: title,
      isDone: false,
    );

    state = AsyncData([...currentTodos, newTodo]);
  }

  void toggleTodo(String id) {
    final currentTodos = state.value ?? [];

    state = AsyncData(
      currentTodos.map((todo) {
        if (todo.id == id) {
          return Todo(id: todo.id, title: todo.title, isDone: !todo.isDone);
        }

        return todo;
      }).toList(),
    );
  }

  void deleteTodo(String id) {
    final currentTodos = state.value ?? [];

    state = AsyncData(currentTodos.where((todo) => todo.id != id).toList());
  }
}

final todoProvider = AsyncNotifierProvider<TodoNotifier, List<Todo>>(
  TodoNotifier.new,
);
