import 'package:flutter/material.dart';
import 'package:weight_calculator/bloc_state_management/screens/result/result_page.dart';
import 'package:weight_calculator/constants.dart';
import 'package:weight_calculator/bloc_state_management/screens/homePage/homepage.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title_,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: const Color(0xFF0F0F1E),
      ),
      debugShowCheckedModeBanner: false,
      // for route management in getx
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(title: 'Bloc ' + title_),
        '/result': (context) => const ResultPage(),
      },
    );
  }
}
