import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const Counter(),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  final int price = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Stream example'),
      ),
      body: Center(
        child: StreamBuilder(
          initialData: price,
          stream: addStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.active) {
              return Text(
                snapshot.data.toString(),
                style: TextStyle(fontSize: 25),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Stream<int> addStream() {
    return Stream<int>.periodic(
      const Duration(seconds: 1),
      (count) => price + count,
    );
  }
}
