import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      title: 'greeting_maker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
  String greeting = "";

  bool _checkAge(String str) {
    return double.tryParse(str) != null;
  }

  void _setGreeting() {
    setState(() {
      greeting = "안녕하세요 $name님, $age ${age > 80 ? "살이나 늙었군요!" : "살이네요."}";
    });
  }

  void _copyGreeting() async {
    await Clipboard.setData(ClipboardData(text: greeting));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.waving_hand_rounded),
        title: Text("인삿말 제조기"),
        actions: [
          GestureDetector(
            onTap: _copyGreeting,
            child: IconButton(
              onPressed: _copyGreeting,
              icon: const Icon(Icons.copy_rounded),
              tooltip: "클립보드에 복사",
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              greeting,
              style: const TextStyle(fontSize: 30),
            ),
            Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: "이름을 입력하세요"),
                  controller: textControllerName,
                  onChanged: (text) {
                    setState(() {
                      name = textControllerName.text;
                    });
                    _setGreeting();
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: "나이를 입력하세요"),
                  controller: textControllerAge,
                  onChanged: (text) {
                    String _age = textControllerAge.text;
                    if (!_checkAge(_age)) {
                      _age = "0";
                    }
                    setState(() {
                      age = int.parse(_age);
                    });
                    _setGreeting();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
