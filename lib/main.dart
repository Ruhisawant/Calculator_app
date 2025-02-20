import 'package:flutter/material.dart';
import 'dart:math';

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

  List<Map<String, dynamic>> buttons = [
    {'name': '1', 'function': () {}, 'color': Colors.brown},
    {'name': '2', 'function': () {}, 'color': Colors.brown},
    {'name': '3', 'function': () {}, 'color': Colors.brown},
    {'name': '+', 'function': () {}, 'color': Colors.orange},
    {'name': '4', 'function': () {}, 'color': Colors.brown},
    {'name': '5', 'function': () {}, 'color': Colors.brown},
    {'name': '6', 'function': () {}, 'color': Colors.brown},
    {'name': '-', 'function': () {}, 'color': Colors.orange},
    {'name': '7', 'function': () {}, 'color': Colors.brown},
    {'name': '8', 'function': () {}, 'color': Colors.brown},
    {'name': '9', 'function': () {}, 'color': Colors.brown},
    {'name': '*', 'function': () {}, 'color': Colors.orange},
    {'name': '.', 'function': () {}, 'color': Colors.brown},
    {'name': '0', 'function': () {}, 'color': Colors.brown},
    {'name': '=', 'function': () {}, 'color': Colors.brown},
    {'name': '/', 'function': () {}, 'color': Colors.orange},
  ];

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
              // Display the list of button names, one on each line
              Text(
                buttonNames.isEmpty
                    ? 'Press a button'
                    : buttonNames.join(''),
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),

              // Grid of buttons
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
                          buttonNames.add(buttons[index]['name']);
                          buttons[index]['function']();
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
