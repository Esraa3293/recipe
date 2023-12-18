import 'package:flutter/material.dart';
import 'package:recipe/pages/login.dart';
import 'package:recipe/services/preferences.service.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? email = PreferencesService.prefs?.getString("email");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF868365),
        title: Text("Welcome $email"),
        actions: [
          IconButton(
            onPressed: () {
              PreferencesService.prefs?.remove("loggedIn");
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(
        child: Text(
          "Home Screen",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
