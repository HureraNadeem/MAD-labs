import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task 3"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        child: const Column(
          children: [
            Row(
              children: [
                Text("T"),
                Spacer(),
                Icon(Icons.star),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text("T")
          ],
        ),
      ),
    );
  }
}
