import 'package:flutter/material.dart';
import 'package:to_do_ist/dataClasses/Task.dart';
import 'db_helper.dart';

class TodoProvider extends ChangeNotifier {
  TodoProvider() {
    getAllTasks();
  }
  List<Task> allTasks;
  List<Task> completeTasks;
  List<Task> inCompleteTasks;
  String testName = 'shaker ahmed ali';
  changeTestName(String newName) {
    this.testName = newName;
    notifyListeners();
  }

  getAllTasks() async {
    this.allTasks = await DbHelper.dbHelper.getAllTasks();

    this.completeTasks =
        this.allTasks.where((element) => element.isCompleted).toList();
    this.inCompleteTasks =
        this.allTasks.where((element) => !element.isCompleted).toList();
    notifyListeners();
  }

  insertTask(Task task) async {
    await DbHelper.dbHelper.createNewTask(task).then((value) {
      if(value==1){ }
      print(value);
    })
    ;
    getAllTasks();
  }

  deleteTask(Task task) async {
    await DbHelper.dbHelper.deleteTask(task);
    getAllTasks();
  }

  updateTask(Task task) async {
    await DbHelper.dbHelper.updateTask(task);
    getAllTasks();
  }
}