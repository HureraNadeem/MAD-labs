class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;
  const Todo(
      {required this.id,
        required this.userId,
        required this.title,
        required this.completed});
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }
}
