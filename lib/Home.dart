import 'package:flutter/material.dart';
import 'package:sqflite_example_2/todo_provider.dart';
import 'todo.dart ';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> todoList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Available Book",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await showModalBottomSheet(
              context: context,
              builder: (context) {
                return BottomSheetCustomWidget();
              });
          setState(() {});
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: TodoProvider.instance.getAllTodo(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if(snapshot.hasData){
              todoList =snapshot.data!;
              return ListView.builder(
                  itemBuilder: (context,index){
                    Todo todo =todoList[index];
                    return Padding(
                        padding: EdgeInsets.all(10),
                      child: ListTile(
                        leading:Image.network(todo.ulr) ,
                        title: Text(todo.title),
                        subtitle:Text(todo.subTitle),
                        trailing:IconButton(
                          onPressed: ()async{
                            if(todo.id !=null)
                              await TodoProvider.instance.deleteTodo(todo.id!);

                            setState(() {});
                          },
                          icon: Icon(Icons.delete_forever),
                        ),


                      ),
                    );
                  }
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      )
    );
  }
}

class BottomSheetCustomWidget extends StatefulWidget {
  const BottomSheetCustomWidget({Key? key}) : super(key: key);

  @override
  State<BottomSheetCustomWidget> createState() =>
      _BottomSheetCustomWidgetState();
}

class _BottomSheetCustomWidgetState extends State<BottomSheetCustomWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: urlController,
            decoration: InputDecoration(hintText: "Book Cover URL",),
          ),
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: "Book Title",),
          ),
          TextField(
            controller: subTitleController,
            decoration: InputDecoration(hintText: "Book Author",),
          ),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              TodoProvider.instance.insertTodo(Todo(

                title: titleController.text,
                subTitle: subTitleController.text,
                ulr: urlController.text,

              ));
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              width: double.infinity,
              color: Colors.blue,
              child: Center(
                child: Text(
                  "ADD",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
