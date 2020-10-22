import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {

  Widget _buildTask(int index){
    return ListTile(
      title: Text('Task Title'),
      subtitle: Text('Oct.22, 2020 • High'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add_circle),
        onPressed: () => print('Task Screen'),
      ),
      body: ListView.builder(
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
        }
      ),
      
    );
  }
}