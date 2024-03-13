import 'package:flutter/material.dart';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:tododatabase/todo_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = openDatabase(
    path.join(await getDatabasesPath(), "ToDo2.db"),
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''CREATE TABLE task
          (id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description Text,
           date INTEGER) ''');
    },
  );

  maplist = await getAllTask();
  print(await getAllTask());
  runApp(const MyApp());
}

dynamic database;
List<ToDoList1> maplist = List.empty(growable: true);

class ToDoList1 {
  int? id;
  String title;
  String description;
  String date;

  ToDoList1(
      {this.id,
      required this.title,
      required this.description,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
    };
  }

  @override
  String toString() {
    return '{id:$id,title:$title,description:$description,experience:$date}';
  }
}

Future insertNewTask(ToDoList1 obj) async {
  final localdb = await database;

  await localdb.insert(
    "task",
    obj.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<ToDoList1>> getAllTask() async {
  final localdb = await database;

  List<Map<String, dynamic>> taskList = await localdb.query("task");
  return List.generate(
      taskList.length,
      (i) => ToDoList1(
          id: taskList[i]['id'],
          title: taskList[i]['title'],
          description: taskList[i]['description'],
          date: taskList[i]['date']));
}

Future<void> updatetask(ToDoList1 obj) async {
  final db = await database;

  await db.update(
    'task',
    obj.toMap(),
    where: 'id = ?',
    whereArgs: [obj.id],
  );
}

Future<void> deletetask(int id) async {
  final db = await database;

  await db.delete(
    'task',
    where: 'id = ?',
    whereArgs: [id],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ToDoList(),
      //home: const ToDoList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
