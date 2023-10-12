//
// @Author: "Eldor Turgunov"
// @Date: 12.10.2023
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_app/business_logic/todo/todo_cubit.dart';

class SearchBarTodo extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () {
          query = '';
        },
        child: const Text('CLEAR'),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final todos = context.read<TodoCubit>().searchTodo(query);

    return todos.isEmpty
        ? const Center(child: Text('Can\'t find todos'))
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(todos[index].title),
            ),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      final todos = context.read<TodoCubit>().searchTodo(query);

      return todos.isEmpty
          ? const Center(child: Text('Can\'t find todos'))
          : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(todos[index].title),
              ),
            );
    }
    return Container();
  }
}
