import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:to_do_ist/dataClasses/Task.dart';
class DbHelper {
  DbHelper._();
  static DbHelper dbHelper = DbHelper._();
  static final String dbName = 'tasks.db';
  static final String tableName = 'tasks';
  static final String idColumn = 'id';
  static final String taskDescriptionColumn = 'descrption';
  static final String taskIsCompleteColumn = 'isCompleted';
  static final String taskDateColumn = 'dueDate';
  static final String taskIsTimeColumn = 'dueTime';
  Database database;

  initDataBase() async{
    database = await createConnection();
  }

  Future<Database> createConnection() async{
    // String path = await getDatabasesPath();
    // path += '$dbName';
    Directory  directory = await getApplicationDocumentsDirectory();
    Database database = await openDatabase(join(directory.path, dbName),version: 1,onCreate:(db, version){
      print('its opened');
      db.execute('''CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $taskDescriptionColumn TEXT, $taskDateColumn TEXT , $taskIsTimeColumn Text , $taskIsCompleteColumn INTEGER)''');
      print('its created');
    });
    return database;
  }
  Future<int> createNewTask(Task task) async {

    try {
      int x = await database.insert(tableName, task.toMap());
      print("added succef"+'${task.toMap()}');
      print('$x');
      return x;
    } on Exception catch (e) {
      print('CreateTask prop');

      return null;
    }
  }
  Future<List<Task>> getAllTasks() async {
    try {
      List<Map<String, dynamic>> results = await database.query(tableName);
      List<Task> taskss = results.map((e) => Task.fromMap(e)).toList();
      print("re succef");
      return taskss;
    } on Exception catch (e) {
      print('kk');

      return null;
    }
  }
  Future<bool> updateTask(Task task) async {
    try {
      await database.update(tableName, task.toMap(),
          where: '$idColumn=?', whereArgs: [task.id]);
      return true;
    } on Exception catch (e) {
      print('updateTask prop');
      return null;
    }
  }
  deleteTask(Task task) async {
    try {
      await database
          .delete(tableName, where: '$idColumn=?', whereArgs: [task.id]);
      return true;
    } on Exception catch (e) {
      print('deleteTask prop');
      return null;
    }
  }


}
