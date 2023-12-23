import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:recipe/pages/home.dart';
import 'package:recipe/pages/login.dart';

class SignUp extends StatefulWidget {
  static const String routeName = 'signUp';

  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  late GlobalKey<FormState> formKey;
  bool obscureText = true;

  @override
  void initState() {
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/recipe.png",
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
                    "Register",
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
                      if (value == null || value.isEmpty) {
                        return "full name is required";
                      }
                      return null;
                    },
                    controller: name,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.person_outline),
                      prefixIconColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "email is required";
                      }
                      if (!EmailValidator.validate(value)) {
                        return "email not valid";
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
                      if (value == null || value.isEmpty) {
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
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        Navigator.pushReplacementNamed(
                            context, HomeScreen.routeName);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      minimumSize: const Size(20, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Already registered?",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: Colors.deepOrange),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
