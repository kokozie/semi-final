import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List todo = <dynamic>[];

  @override
  void initState() {
    super.initState();
    showTodo();
  }

  showTodo() async {
    var url = 'https://jsonplaceholder.typicode.com/todos';
    var response = await http.get(Uri.parse(url));

    setState(() {
      todo = convert.jsonDecode(response.body) as List<dynamic>;
    });
  }

  removeTodo() async {
    var url =
    Uri.parse("https://jsonplaceholder.typicode.com/todos/id%22");
        var response = await http.delete(url);
    if (response.statusCode == 200){
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deleted Successfully'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Http Get and Delete'),
        ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: todo.length,
          itemBuilder: (context,index){
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction){
                setState(() {
                  todo.removeAt(index);
                  removeTodo();
                });
                },
              child: Card(
                elevation:4,
                child: ListTile
                  (title: Text(todo[index]['title'])
                ),
              ),
            );
           }
           )
      )
    );
  }
}
