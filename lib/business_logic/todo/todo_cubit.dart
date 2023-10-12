import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../data/todo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit()
      : super(
          TodoInitial(
            [
              Todo(id: UniqueKey().toString(), title: 'title', isDone: true),
              Todo(id: UniqueKey().toString(), title: 'desc', isDone: false),
              Todo(id: UniqueKey().toString(), title: 'Home', isDone: false),
            ],
          ),
        );

  void addTodo(String title) {
    try {
      final todo = Todo(id: UniqueKey().toString(), title: title);
      final todos = state.todos;
      todos!.add(todo);
      emit(TodoAdded());
      emit(TodoState(todos: todos));
    } catch (e) {
      emit(const TodoError('message'));
    }
  }

  void editTodo(String id, String title) {
    try {
      final todos = state.todos!.map((e) {
        if (e.id == id) {
          return Todo(id: id, title: title, isDone: e.isDone);
        }
        return e;
      }).toList();
      emit(TodoEdited());
      emit(TodoState(todos: todos));
    } catch (e) {
      emit(const TodoError('message'));
    }
  }

  void toggleTodo(String id) {
    try {
      final todos = state.todos!.map((e) {
        if (e.id == id) {
          return Todo(id: id, title: e.title, isDone: !e.isDone);
        }
        return e;
      }).toList();
      emit(TodoToggled());
      emit(TodoState(todos: todos));
    } catch (e) {
      emit(const TodoError('message'));
    }
  }

  void todoDelete(String id) {
    final todo = state.todos;
    todo!.removeWhere((element) => element.id == id);
    emit(TodoDelete());
    emit(TodoState(todos: todo));
  }

  List<Todo> searchTodo(String title) {
    return state.todos!
        .where(
          (element) =>
              element.title.toLowerCase().contains(title.toLowerCase()),
        )
        .toList();
  }
}
