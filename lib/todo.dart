import 'package:sqflite_example_2/todo_provider.dart';

class Todo{
  int? id;
  late String title;
  late String subTitle;
  late String ulr;

  Todo({
    this.id,
    required this.title,
    required this. subTitle,
    required this. ulr,
});

  Todo.forMap(Map<String , dynamic>map){
    if(map[columnId != null]) this.id=map[columnId];
    this.title=map[columnTitle];
    this.subTitle=map[columnSubTitle];
    this.ulr =map[columnUrl];
   }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (this.id != null) map[columnId] = this.id;
    map[columnTitle] = this.title;
    map[columnSubTitle] = this.subTitle;
    map[columnUrl] = this.ulr;

    return map;
  }


}


