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
    getTodo();
  }

  getTodo() async {
    var url = 'https://jsonplaceholder.typicode.com/todos';
    var response = await http.get(Uri.parse(url));

    setState(() {
      todo = convert.jsonDecode(response.body) as List<dynamic>;
    });
  }

  deleteTodo() async {
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
          title: const Text('API'),
        ),
      body: Center(
        child:  ListView.builder(
                itemCount: todo.length,
                itemBuilder: (context,index){
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction){
                      setState(() {
                        todo.removeAt(index);
                        deleteTodo();
                      });
                    },
                    child: ListTile(
                      title: Text(todo[index]['title']),
                      ),
                    );
                },
        ),
      ),
    );
  }
}
