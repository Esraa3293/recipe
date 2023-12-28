import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recipe/pages/home.dart';
import 'package:recipe/pages/intro_page.dart';
import 'package:recipe/services/preferences.service.dart';
import 'package:recipe/utils/images.dart';

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
                : IntroPage.routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImagesPath.background), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImagesPath.baseHeader),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
