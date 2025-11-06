

import 'package:flutter/material.dart';
import 'bus_page.dart';  

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Pass Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFEAF6FF), // faint sky blue
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEAF6FF), // faint sky blue
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      home: const BusPassPage(),
    );
  }
}
