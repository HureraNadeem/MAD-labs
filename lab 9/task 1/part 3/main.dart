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
  Future<String> fetchUsername() async {
    await Future.delayed(const Duration(seconds: 3));
    return 'Hurera';
  }

  String addHello(String user) {
    return 'Hello $user';
  }

  Future<String> greetUser() async {
    try {
      String username = await fetchUsername();
      return addHello(username);
    } catch (error) {
      return 'Error greeting user: ${error.toString()}';
    }
  }

  Future<String> sayGoodbye() async {
    try {
      String result = await logoutUser();
      return '$result Thanks, see you next time';
    } catch (error) {
      return 'Error saying goodbye: ${error.toString()}';
    }
  }

  Future<String> logoutUser() async {
    return Future.delayed(const Duration(milliseconds: 500), () => 'Hurera');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task 1'),
      ),
      body: Center(
        child: FutureBuilder(
          future: greetUser(),
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
        onPressed: () async {
          String message = await sayGoodbye();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
