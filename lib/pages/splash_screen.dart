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
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context,
          checkLoggedIn() ? HomeScreen.routeName : LoginScreen.routeName);
    });
    super.initState();
  }

  checkLoggedIn() {
    bool isLogged = PreferencesService.prefs?.getBool("loggedIn") ?? false;
    return isLogged;
  }

  checkKey() {
    bool isLogged = PreferencesService.prefs?.containsKey("loggedIn") ?? false;
    return isLogged;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/recipe.png"),
              fit: BoxFit.cover)),
    );
  }
}
