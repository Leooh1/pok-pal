import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

TextEditingController textControllerName = TextEditingController();
TextEditingController textControllerAge = TextEditingController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = "_";
  int age = 0;

  bool _checkAge(String str) {
    if (str == null) {
      return true;
    }
    return double.tryParse(str) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "안녕하세요 $name님\n$age ${age > 80 ? "살이나 늙었군요!" : "살이네요."}",
              style: TextStyle(fontSize: 30),
            ),
            TextField(
              decoration: InputDecoration(labelText: "이름을 입력하셈요"),
              controller: textControllerName,
              onChanged: (text) {
                setState(() {
                  name = textControllerName.text;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "나이를 입력하세요"),
              controller: textControllerAge,
              onChanged: (text) {
                String _age = textControllerAge.text;
                if (!_checkAge(_age)) {
                  _age = "0";
                }
                setState(() {
                  age = int.parse(_age);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
