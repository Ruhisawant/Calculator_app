import 'package:flutter/material.dart';

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
  List<String> buttonNames = [];
  String textToDisplay = '';
  String result = '';
  String operation = '';
  int firstNum = 0;
  int secondNum = 0;

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

  String calculate() {
    try {
      String expression = buttonNames.join('');
      return _evaluateExpression(expression).toString();
    } catch (e) {
      return 'Error';
    }
  }

  double _evaluateExpression(String expression) {
    if (expression.contains('+')) {
      var parts = expression.split('+');
      return double.parse(parts[0]) + double.parse(parts[1]);
    } else if (expression.contains('-')) {
      var parts = expression.split('-');
      return double.parse(parts[0]) - double.parse(parts[1]);
    } else if (expression.contains('*')) {
      var parts = expression.split('*');
      return double.parse(parts[0]) * double.parse(parts[1]);
    } else if (expression.contains('/')) {
      var parts = expression.split('/');
      return double.parse(parts[0]) / double.parse(parts[1]);
    } else {
      return double.parse(expression);
    }
  }

  void clearScreen() {
    setState(() {
      buttonNames.clear();
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
              // Display Button Names
              Text(
                buttonNames.isEmpty
                    ? 'Press a button'
                    : buttonNames.join(''),
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),

              // Grid of Buttons
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
                      onTap: () {
                        setState(() {
                          if (buttons[index]['name'] == '=') {
                            // Perform calculation
                            buttonNames = [calculate()];
                          } else {
                            // Add the button name to the list
                            buttonNames.add(buttons[index]['name']);
                          }
                        });
                      },
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

              // Clear Button
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
