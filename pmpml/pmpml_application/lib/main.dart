

import 'package:flutter/material.dart';
import 'bus_page.dart';
import 'choose_color_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _backgroundColor = const Color(0xFFEAF6FF); // default faint sky blue

  void _changeBackgroundColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Pass Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: _backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: _backgroundColor,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      home: BusPassPage(
        backgroundColor: _backgroundColor,
        onColorChange: _changeBackgroundColor,
      ),
    );
  }
}
