import 'package:flutter/material.dart';
import 'package:api_concepts/home_screen.dart';
import 'package:http/http.dart';
import 'package:api_concepts/example_two.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const ExampleTwo()
      //const HomeScreen(),
    );
  }
}

