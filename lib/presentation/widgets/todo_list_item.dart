//
// @Author: "Eldor Turgunov"
// @Date: 11.10.2023
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_app/business_logic/todo/todo_cubit.dart';

import '../../data/todo.dart';
import 'manage_todo.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;

  const TodoListItem({
    super.key,
    required this.todo,
  });

  void openManageTodo(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) => ManageTodo(todo: todo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () => context.read<TodoCubit>().toggleTodo(todo.id),
        icon: Icon(
          todo.isDone ? Icons.check_circle : Icons.circle_outlined,
          color: Colors.teal,
        ),
      ),
      title: Text(
        todo.title,
        style: TextStyle(
            decoration:
                todo.isDone ? TextDecoration.lineThrough : TextDecoration.none),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => openManageTodo(context),
            icon: const Icon(
              Icons.edit,
              color: Colors.teal,
            ),
          ),
          IconButton(
            onPressed: () => context.read<TodoCubit>().todoDelete(todo.id),
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
