import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _priority;
  DateTime _date = DateTime.now();

  TextEditingController _dateController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  final List<String> _priorities = ['Low', 'Medium', 'High'];

  @override
  void initState() { 
    super.initState();
    _dateController.text = _dateFormatter.format(_date);
  }

  @override
  void dispose() { 
    _dateController.dispose();
    super.dispose();
    
  }

  _handleDatePicker() async{
    final DateTime date = await showDatePicker(
      context: context, 
      initialDate: _date, 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2036),
      );

      if (date != null && date != _date) {
        setState(() {
          _date = date;
        });
        _dateController.text = _dateFormatter.format(date);
      }
  }

  _submit(){
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('$_title, $_date, $_priority');

      //insert task to user's db

      //update task


      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 25.0,
                  color: Theme.of(context).primaryColor
                  ),
              ),
              SizedBox(height: 20.0,),
              Text('Add Task', 
              style: TextStyle(
                color: Colors.black, 
                fontSize: 40.0, 
                fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0,),
              Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: TextFormField(
                      style: TextStyle(fontSize: 15.0),
                      decoration: InputDecoration(
                        labelText: 'Task Title',
                        labelStyle: TextStyle(fontSize: 18.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        )
                      ),
                      validator: (input) => input.trim().isEmpty ? 'Please enter task title' : null,
                      onSaved: (input) => _title = input,
                      initialValue: _title,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: TextFormField(
                      readOnly: true,
                      controller: _dateController,
                      style: TextStyle(fontSize: 15.0),
                      onTap: _handleDatePicker,
                      decoration: InputDecoration(
                        labelText: 'Task Date',
                        labelStyle: TextStyle(fontSize: 18.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        )
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: DropdownButtonFormField(
                      isDense: true,
                      icon: Icon(Icons.arrow_drop_down_circle),
                      iconSize: 22.0,
                      iconEnabledColor: Theme.of(context).primaryColor,
                      items: _priorities.map((String priority) {
                        return DropdownMenuItem(
                          value: priority,
                          child: Text(priority, style: TextStyle(color: Colors.black, fontSize: 15.0,),),
                        );
                      }).toList(),
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        labelText: 'Task Priority',
                        labelStyle: TextStyle(fontSize: 18.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        )
                      ),
                      validator: (input) => _priority == null ? 'Please select a priority level' : null,
                      // onSaved: (input) => _priority = input,
                      onChanged: (value) {
                        setState(() {
                          _priority = value;
                        });
                      },
                      value: _priority,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, 
                    borderRadius: BorderRadius.circular(60.0),
                    ),
                    child: FlatButton(
                      child: Text('Add', 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                      ),
                      onPressed: _submit,
                    ),
                  ),
                 ],
                ),
              )
             ],
            ),
          ),
        ),
      ),
    );
  }
}