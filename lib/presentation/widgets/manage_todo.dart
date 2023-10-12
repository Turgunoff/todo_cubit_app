//
// @Author: "Eldor Turgunov"
// @Date: 11.10.2023
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_cubit_app/business_logic/todo/todo_cubit.dart';

import '../../data/todo.dart';

class ManageTodo extends StatefulWidget {
  final Todo? todo;

  const ManageTodo({
    super.key,
    this.todo,
  });

  @override
  State<ManageTodo> createState() => _ManageTodoState();
}

class _ManageTodoState extends State<ManageTodo> {
  final _key = GlobalKey<FormState>();

  String _title = '';

  void _submit(BuildContext context) {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      if (widget.todo == null) {
        // BlocProvider.of<TodoCubit>(context).addTodo(_title);
        context.read<TodoCubit>().addTodo(_title);
      } else {
        // BlocProvider.of<TodoCubit>(context)
        //     .editTodo(Todo(id: todo!.id, title: _title, isDone: todo!.isDone));
        context.read<TodoCubit>().editTodo(widget.todo!.id, _title);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoCubit, TodoState>(
      listener: (context, state) {
        if (state is TodoAdded || state is TodoEdited) {
          Navigator.of(context).pop();
        } else if (state is TodoError) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Error'),
              content: Text(state.message),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.todo == null ? '' : widget.todo!.title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter title';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _title = newValue!;
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 16)),
                      child: const Text('CANCEL')),
                  ElevatedButton(
                      onPressed: () => _submit(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 16)),
                      child: Text(widget.todo == null ? 'SUBMIT' : 'EDIT')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
