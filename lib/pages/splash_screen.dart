import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recipe/pages/home.dart';
import 'package:recipe/pages/login.dart';
import 'package:recipe/services/preferences.service.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initSplash();
    super.initState();
  }

  void initSplash() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(
            context,
            PreferencesService.checkLoggedIn()
                ? HomeScreen.routeName
                : LoginScreen.routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/recipe.png"),
                fit: BoxFit.cover)),
      ),
    );
  }
}
