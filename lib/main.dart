import 'package:flutter/material.dart';
import 'package:recipe/pages/home.dart';
import 'package:recipe/pages/intro_page.dart';
import 'package:recipe/pages/login.dart';
import 'package:recipe/pages/sign_up.dart';
import 'package:recipe/pages/splash_screen.dart';
import 'package:recipe/services/preferences.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    PreferencesService.prefs = await SharedPreferences.getInstance();
    if (PreferencesService.prefs != null) {
      print("Preferences init successfully");
    }
  } catch (e) {
    print("Error in Preferences init $e");
  }

  runApp(const MyApplication());
}

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey)),
      )),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUp.routeName: (context) => const SignUp(),
        HomeScreen.routeName: (context) => HomeScreen(),
        IntroPage.routeName: (context) => const IntroPage(),
        SplashScreen.routeName: (context) => const SplashScreen(),
      },
    );
  }
}
