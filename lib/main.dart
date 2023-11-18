import 'package:flutter/material.dart';
import 'package:my_run_club/screens/activities_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Run Club",
      theme: ThemeData(
        dialogBackgroundColor: const Color(0xFFF7F6F7),
        brightness: Brightness.light,
        primaryColor: Colors.black,
      ),
      home: const ActivitiesScreen(),
    );
  }
}
