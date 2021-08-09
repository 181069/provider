import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Task {
  int id;
  String descrption;
  bool isCompleted;
  DateTime dueDate;
  TimeOfDay dueTime;

  Task({this.id, @required this.descrption, @required this.isCompleted ,@required this.dueDate,@required this.dueTime});

  Map<String,dynamic> toMap(){
    return {
      'descrption' : descrption,
      'isCompleted' : isCompleted ? 1 : 0 ,
      'dueDate' : DateFormat('yyyy-MM-dd').format(dueDate),
      'dueTime' : '${dueTime.hour} : ${dueTime.minute}',
    };
  }
    factory Task.fromMap(Map<String,dynamic> map){
    return Task(
      id: map['id'],
      descrption : map['descrption'],
      isCompleted : map['isCompleted'] == 1 ? true : false ,
      dueDate : DateTime.parse(map['dueDate']),
      dueTime : TimeOfDay(hour:15,minute:8),
    );
    }

}