import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: Text(
          "MRC",
          style: TextStyle(
              fontSize: 90, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
