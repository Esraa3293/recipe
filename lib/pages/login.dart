import 'package:flutter/material.dart';
import 'package:recipe/pages/home.dart';
import 'package:recipe/pages/sign_up.dart';
import 'package:recipe/services/preferences.service.dart';
import 'package:recipe/utils/images.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController email;
  late TextEditingController password;
  late GlobalKey<FormState> formKey;
  bool obscureText = true;

  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            ImagesPath.background,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if (value.isEmpty) {
                        return "email is required";
                      } else if (!emailValid) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.email_outlined),
                      prefixIconColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      bool passwordValid = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(value!);
                      if (value.isEmpty) {
                        return "password is required";
                      } else if (!passwordValid) {
                        return "password not valid";
                      }
                      return null;
                    },
                    controller: password,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(Icons.lock_outline),
                        prefixIconColor: Colors.grey,
                        suffixIcon: InkWell(
                            onTap: () {
                              obscureText = !obscureText;
                              setState(() {});
                            },
                            child: Icon(obscureText
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        suffixIconColor: Colors.grey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.routeName);
                        await PreferencesService.prefs
                            ?.setBool("loggedIn", true);
                        await PreferencesService.prefs
                            ?.setString("email", email.text);
                        setState(() {});
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      minimumSize: const Size(20, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account?",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, SignUp.routeName);
                },
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.deepOrange),
                )),
          ],
        ),
      ),
    );
  }
}
