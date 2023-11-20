import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_run_club/screens/activities_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDefault();
  await initializeDateFormatting();

  runApp(const MyApp());
}

Future<void> initializeDefault() async {
  FirebaseApp app = await Firebase.initializeApp();

  print('Initialized default app $app');
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
