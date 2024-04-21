import 'dart:convert';

import 'package:labtask2/models/todo_model.dart';

import 'package:http/http.dart' as http;

class TodoService {
  Future<List<Todo>> fetchTodos() async {
    List<Todo> todos = [];
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      for (final todo in data) {
        todos.add(Todo.fromJson(todo));
      }
    } else {
      throw Exception("Something Went Wrong");
    }
    return todos;
  }
}
