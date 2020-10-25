class Task{
  int id;
  String title;
  DateTime date;
  String priority;
  int status;

  Task({this.title, this.date, this.priority, this.status});

  Task.withId({this.id, this.title, this.date, this.priority, this.status});

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();

    map['id'] = id;
    map['title'] = title;
    map['date'] = date.toIso8601String();
    map['priority'] = priority;
    map['status'] = status;

    return map;
  }
}