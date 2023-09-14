import 'package:flutter/material.dart';
import 'package:flashlight_app/screens/flashlight_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashlight App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const FlashLightScreen(),
    );
  }
}
