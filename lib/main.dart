import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_ist/dataClasses/Task.dart';
import 'package:to_do_ist/providers/db_helper.dart';
import 'package:to_do_ist/providers/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await DbHelper.dbHelper.initDataBase();
  runApp(ChangeNotifierProvider<TodoProvider>(
      create: (context) => TodoProvider(),
      child:MyApp()));
}

class MyApp extends StatelessWidget  {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title}) : super(key: key);


  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Task task = Task(id: 1,descrption: 'do homework',dueDate: DateTime.utc(1999,5,9),dueTime: TimeOfDay(hour: 8, minute: 5),isCompleted: false);

  void _incrementCounter() {

    setState( ()  {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text('id is' + '${task.id}'),
            Text('description is '+ task.descrption),
            Text('date is'+ '${task.dueDate}'),
            Text('time is'+ '${task.dueTime}'),
            Text('isCompleted is'+ '${task.isCompleted}'),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() async {
          Provider.of<TodoProvider>(context, listen: false)
              .insertTask(task);

          List<Task> t = Provider.of<TodoProvider>(context, listen: false)
              .allTasks;
          print(t.toString());
        } ,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
