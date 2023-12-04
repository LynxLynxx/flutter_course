import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_course/models/todo_model.dart';
import 'package:flutter_course/widgets/todo_bottomsheet.dart';
import 'package:flutter_course/widgets/todo_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoModel> todos = [];
  int todoNumber = 0;
  late SharedPreferences pref;

  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  void loadSharedPreferences() async {
    pref = await SharedPreferences.getInstance();
    loadToDo();
  }

  Future<void> saveTodo() async {
    List<String> todoStringList =
        todos.map((e) => jsonEncode(e.toJson())).toList();

    await pref.setStringList("todo", todoStringList);
  }

  Future<void> loadToDo() async {
    List<String>? todoStringList = pref.getStringList("todo");
    print(todoStringList);

    if (todoStringList == null) return;

    setState(() {
      todos = todoStringList
          .map((e) => TodoModel.fromJson(json.decode(e)))
          .toList();
    });
  }

  void addTodo() {
    showModalBottomSheet(
        context: context, builder: (context) => TodoBottomSheet()).then(
      (value) async {
        setState(
          () {
            todos.add(TodoModel(text: value));
          },
        );
        await saveTodo();
      },
    );
  }

  void removeTodo(TodoModel todo) async {
    setState(() {
      todos.removeWhere((element) => element.text == todo.text);
    });
    await saveTodo();
  }

  void onTodoChange(TodoModel todo) async {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    await saveTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          title: Text("To do"),
          centerTitle: true,
          actions: [
            /*MaterialButton(
            color: Theme.of(context).primaryColor,
            shape: CircleBorder(),
            onPressed: () {},
            child: Icon(Icons.add),
          ),*/
            IconButton(
              onPressed: addTodo,
              icon: Icon(
                Icons.add,
              ),
            ),
          ],
        ),
        body: todos.isEmpty
            ? Center(
                child: Text("Dodaj pierwsze todo"),
              )
            : ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) => TodoWidget(
                  todo: todos[index],
                  removeToDo: (TodoModel todo) {
                    removeTodo(todo);
                  },
                  onTodoChange: (TodoModel todo) {
                    onTodoChange(todo);
                  },
                ),
              ));
  }
}
