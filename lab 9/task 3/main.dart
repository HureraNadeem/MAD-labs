import 'package:flutter/material.dart';
import 'package:labtask3/services/todo_service.dart';

import 'models/todo_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Todo>> todos;
  @override
  void initState() {
    super.initState();
    todos = getTodos();
  }

  Future<List<Todo>> getTodos() async {
    return await TodoService().fetchTodos();
  }

  void retry() {
    setState(() {
      todos = TodoService().fetchTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showAlert = false;
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      title: 'Lab9-Task3',
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: retry,
          child: const Text('Go'),
        ),
        backgroundColor: const Color.fromARGB(126, 214, 208, 208),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('API Response'),
        ),
        body: FutureBuilder<List<Todo>>(
          future: todos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final _todos = snapshot.data!;
              return ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'ID',
                                style: TextStyle(color: Colors.red),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(_todos[index].id.toString())
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Title',
                                style: TextStyle(color: Colors.red),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    _todos[index].title),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              final errorMessage = snapshot.error.toString().substring(10);
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  alertMessage(context, errorMessage);
                },
              );
              return Center(
                child: Text(errorMessage,
                    style: const TextStyle(color: Colors.white)),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<dynamic> alertMessage(BuildContext context, String errorMessage) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(errorMessage),
      ),
    );
  }
}
