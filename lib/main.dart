import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String textToDisplay = '';

  List<Map<String, dynamic>> buttons = [
    {'name': '1', 'color': Colors.brown},
    {'name': '2', 'color': Colors.brown},
    {'name': '3', 'color': Colors.brown},
    {'name': '+', 'color': Colors.orange},
    {'name': '4', 'color': Colors.brown},
    {'name': '5', 'color': Colors.brown},
    {'name': '6', 'color': Colors.brown},
    {'name': '-', 'color': Colors.orange},
    {'name': '7', 'color': Colors.brown},
    {'name': '8', 'color': Colors.brown},
    {'name': '9', 'color': Colors.brown},
    {'name': '*', 'color': Colors.orange},
    {'name': '.', 'color': Colors.brown},
    {'name': '0', 'color': Colors.brown},
    {'name': '=', 'color': Colors.brown},
    {'name': '/', 'color': Colors.orange},
  ];

  String calculate(String expression) {
  try {
    if (expression.contains('/0')) {
      return 'Error';
    }
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    if (eval.isInfinite || eval.isNaN) {
      return 'Error';
    }
    return eval.toString();
  } catch (e) {
    return 'Error';
  }
}


  void buttonClick(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        textToDisplay = '';
      } else if (buttonText == '=') {
        String result = calculate(textToDisplay);
        textToDisplay = result;
      } else {
        textToDisplay += buttonText;
      }
    });
  }

  void clearScreen() {
    setState(() {
      textToDisplay = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textToDisplay.isEmpty ? 'Press a button' : textToDisplay,
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 500,
                height: 500,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: buttons.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => buttonClick(buttons[index]['name']),
                      child: Container(
                        decoration: BoxDecoration(
                          color: buttons[index]['color'],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        height: 80,
                        width: 80,
                        child: Text(
                          buttons[index]['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: clearScreen,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  height: 50,
                  width: 150,
                  child: const Text(
                    'Clear',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}