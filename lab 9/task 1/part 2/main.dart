import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<int> fetchLoginAmount() async {
    await Future.delayed(const Duration(seconds: 1));
    return 57;
  }

  Future<String> fetchNewUsername() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'Hurera';
  }

  Future<String> reportLogins() async {
    try {
      int loginNumber = await fetchLoginAmount();
      return 'Total number of logins: $loginNumber';
    } catch (error) {
      return 'Error fetching login details';
    }
  }

  Future<String> changeUsername() async {
    try {
      String username = await fetchNewUsername();
      return username;
    } catch (error) {
      return 'Error changing username: ${error.toString()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task 1'),
      ),
      body: Center(
        child: FutureBuilder(
          future: reportLogins(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text('${snapshot.data}');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
