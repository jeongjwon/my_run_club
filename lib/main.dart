import 'package:flutter/material.dart';
import 'package:my_run_club/screens/intro_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:my_run_club/provider/task_provider.dart';
import 'package:my_run_club/screens/activities_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDefault();
  await initializeDateFormatting();

  runApp(ChangeNotifierProvider(
      create: (context) => TaskProvider(), child: const MyApp()));
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
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko'),
          Locale('en'),
        ],
        theme: ThemeData(
          dialogBackgroundColor: const Color(0xFFF5F5F5),
          brightness: Brightness.light,
          primaryColor: Colors.black,
        ),
        home: FutureBuilder(
          future: Future.delayed(
              const Duration(seconds: 4), () => "Intro Completed."),
          builder: (context, snapshot) {
            return AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                child: _splashLoadingWidget(snapshot));
          },
        ));
  }
}

Widget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
  if (snapshot.hasError) {
    return const Text("Error!!");
  } else if (snapshot.hasData) {
    return const ActivitiesScreen();
  } else {
    return const IntroScreen();
  }
}
