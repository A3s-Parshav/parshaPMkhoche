import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bus_page.dart';
import 'choose_color_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Disable edge-to-edge mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);

  // Set status bar color
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0E98BA),
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(MyApp());
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
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0E98BA),
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xFF0E98BA),
            statusBarIconBrightness: Brightness.light,
          ),
          elevation: 0,
        ),
      ),
      home: BusPassPage(
        backgroundColor: _backgroundColor,
        onColorChange: _changeBackgroundColor,
      ),
    );
  }
}
