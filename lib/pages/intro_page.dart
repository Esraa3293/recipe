import 'package:flutter/material.dart';
import 'package:recipe/pages/login.dart';
import 'package:recipe/pages/sign_up.dart';
import 'package:recipe/utils/images.dart';
import 'package:recipe/widgets/button_widget.dart';

class IntroPage extends StatelessWidget {
  static const String routeName = "Intro";

  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImagesPath.background,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
                child: Image.asset(ImagesPath.baseHeader),
              ),
              const Text(
                "Cooking Done The Easy Way",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ButtonWidget(SignUp.routeName, "Register"),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(LoginScreen.routeName, "Sign In")
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
