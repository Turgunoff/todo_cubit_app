//
// @Author: "Eldor Turgunov"
// @Date: 11.10.2023
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_app/presentation/widgets/search_bar.dart';

import '../../business_logic/todo/todo_cubit.dart';
import '../widgets/manage_todo.dart';
import '../widgets/todo_list_item.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  void openManageTodo(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) => const ManageTodo(),
    );
  }

  void openSearchBar(BuildContext context) {
    showSearch(context: context, delegate: SearchBarTodo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo'),
        actions: [
          IconButton(
            onPressed: () => openSearchBar(context),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () => openManageTodo(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.todos!.length,
            itemBuilder: (context, index) => TodoListItem(
              todo: state.todos![index],
            ),
          );
        },
      ),
    );
  }
}
