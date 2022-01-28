import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_calculator/constants.dart';
import 'package:weight_calculator/getx_state_management/screens/homePage/homepage.dart';
import 'package:weight_calculator/getx_state_management/screens/result/result_page.dart';
//import 'default_state_management/screens/homePage/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: title_,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: const Color(0xFF0F0F1E),
      ),
      //home: const HomePage(title: 'GetX ' + title_),
      debugShowCheckedModeBanner: false,
      // for route management in getx
      initialRoute: '/home',
      getPages: [
        GetPage(
            name: '/home', page: () => const HomePage(title: 'GetX ' + title_)),
        GetPage(name: '/result', page: () => const ResultPage())
      ],
    );
  }
}
