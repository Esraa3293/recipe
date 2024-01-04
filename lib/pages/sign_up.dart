import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe/pages/home.dart';
import 'package:recipe/pages/login.dart';
import 'package:recipe/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {

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
                    style: const TextStyle(color: Colors.white),
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
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
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
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
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
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: InkWell(
                          onTap: () {
                            obscureText = !obscureText;
                            setState(() {});
                          },
                          child: Icon(obscureText
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        await GetIt.I
                            .get<SharedPreferences>()
                            .setBool("loggedIn", true);
                        await GetIt.I
                            .get<SharedPreferences>()
                            .setString("name", name.text);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ));
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
                      "Register",
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
              "Already registered?",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: Colors.deepOrange),
                )),
          ],
        ),
      ),
    );
  }
}
