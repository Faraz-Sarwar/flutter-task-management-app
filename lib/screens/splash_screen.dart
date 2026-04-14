import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task_manager/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  //BONUS TASK of internship final project, splash screen for this to do app
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      // Navigate to Home Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/splash_image.png',
        fit: BoxFit.fill,
        height: double.infinity,
      ),
    );
  }
}
