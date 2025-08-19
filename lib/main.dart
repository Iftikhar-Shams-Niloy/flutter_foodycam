import 'package:flutter/material.dart';
import 'presentation/pages/home_screen.dart';

void main() {
  runApp(const FoodClassifierApp());
}

class FoodClassifierApp extends StatelessWidget {
  const FoodClassifierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Classifier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}
