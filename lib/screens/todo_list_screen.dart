import 'package:flutter/material.dart';
import 'package:todolist_app/helpers/database_helper.dart';
import 'package:todolist_app/models/task_modal.dart';
import 'package:todolist_app/screens/add_task_screen.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {

  Future<List<Task>> _taskList;

  @override
  void initState() { 
    super.initState();
    _updateTaskList();
  }

  _updateTaskList() {
    setState(() {
      _taskList = DatabaseHelper.instance.getTaskList();
    });
  }

  Widget _buildTask(int index){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
        ListTile(
        title: Text('Task Title'),
        subtitle: Text('Oct.22, 2020 • High'),
        trailing: Checkbox(onChanged: (value){
          print(value);
        },
        activeColor: Theme.of(context).primaryColor,
        value: true,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add_circle),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddTaskScreen(),
         ),
        ),
      ),
      body: FutureBuilder(
        future: _taskList,
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
              return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 40.0),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            if(index == 0){
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('My Tasks', style: TextStyle(color: Colors.black, fontSize: 40.0, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10.5,),
                  Text('1 of 5', style: TextStyle(color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.w600),),
                ],
                ),
              );
            }
            return _buildTask(index);
          },
        );
        },
      ),
      
    );
  }
}