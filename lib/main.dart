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
    return CupertinoApp(
      title: 'greeting_maker',
      debugShowCheckedModeBanner: false,
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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Icon(Icons.waving_hand),
        middle: Text("인삿말 제조기"),
        trailing: GestureDetector(
          onTap: _copyGreeting,
          child: IconButton(
            onPressed: _copyGreeting,
            icon: const Icon(Icons.copy),
            tooltip: "클립보드에 복사",
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                  CupertinoTextField(
                    placeholder: "이름을 입력하세요",
                    controller: textControllerName,
                    onChanged: (text) {
                      setState(() {
                        name = textControllerName.text;
                      });
                      _setGreeting();
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CupertinoTextField(
                    placeholder: "나이를 입력하세요ㅗ",
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
      ),
    );
  }
}
