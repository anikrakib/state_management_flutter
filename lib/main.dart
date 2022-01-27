import 'package:flutter/material.dart';
import 'package:weight_calculator/constants.dart';
import 'package:weight_calculator/screens/homePage/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: const Color(0xFF0F0F1E),
      ),
      home: const HomePage(title: title),
      debugShowCheckedModeBanner: false,
    );
  }
}
