import 'package:flutter/material.dart';
import 'package:sqflite_example_2/todo_provider.dart';

import 'Home.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  TodoProvider.instance.open();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
