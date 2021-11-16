import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_bloc_todo/models/todo_model.dart';
import 'package:rxdart/subjects.dart';

class TodoBloc extends BlocBase {
  final List<Todo> _todoList = [];

  List<Todo> get todoList => _todoList;

  final _controller = BehaviorSubject<List<Todo>>();
  Stream get output => _controller.stream;
  Sink get input => _controller.sink;

  void add(Todo todo) async {
    _todoList.add(todo);

    input.add(_todoList);
  }

  void remove(Todo todo) async {
    _todoList.remove(todo);

    input.add(_todoList);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
