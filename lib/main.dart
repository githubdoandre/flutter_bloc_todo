import 'package:flutter/material.dart';
import 'package:flutter_bloc_todo/blocs/todo_bloc.dart';
import 'package:flutter_bloc_todo/models/todo_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _todoBloc = TodoBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: _todoBloc.output,
          builder: (context, snapshot) => Text(
            _todoBloc.todoList.length.toString(),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _todoBloc.output,
        builder: (context, AsyncSnapshot snapshot) => ListView.builder(
          itemCount: snapshot.data != null ? snapshot.data.length : 0,
          itemBuilder: (c, i) => ListTile(
            trailing: IconButton(
                onPressed: () => _todoBloc.remove(_todoBloc.todoList[i]),
                icon: const Icon(Icons.delete)),
            title: Text(
              _todoBloc.todoList[i].title.toString(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _todoBloc.add(
          Todo(id: 1, title: 'todo ${_todoBloc.todoList.length + 1}'),
        ),
      ),
    );
  }
}
