import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:providers/provider/todo_riverpod.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: todos.when(
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          return Center(child: Text('Error: $error'));
        },
        data: (todoList) {
          return ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              final todo = todoList[index];

              return ListTile(
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (_) {
                    ref.read(todoProvider.notifier).toggleTodo(todo.id);
                  },
                ),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref.read(todoProvider.notifier).deleteTodo(todo.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
