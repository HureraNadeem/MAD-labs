import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:labtask3/models/todo_model.dart';

import 'package:http/http.dart' as http;

class TodoService {
  // check internet connectivity
  Future<bool> isConnected() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      return true;
    } else {
      return false;
    }
  }

  // Fetch API response
  Future<List<Todo>> fetchTodos() async {
    // remove checker if on web otherwise check connectivity
    if (!kIsWeb && (await isConnected()) == false) {
      throw Exception('Internet Not Connected!');
    }
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
      throw Exception("Cannot get data");
    }
    return todos;
  }
}
