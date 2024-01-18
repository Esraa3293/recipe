import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe/pages/home.dart';
import 'package:recipe/pages/login.dart';
import 'package:recipe/pages/sign_up.dart';

class AppAuthProvider extends ChangeNotifier {
  GlobalKey<FormState>? formKey;
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool obsecureText = false;

  void init() {
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void providerDispose() {
    formKey = null;
    nameController = null;
    emailController = null;
    passwordController = null;
    obsecureText = false;
  }

  void toggleObsecure() {
    obsecureText = !obsecureText;
    notifyListeners();
  }

  void openSignUpScreen(BuildContext context) {
    providerDispose();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SignUp(),
        ));
  }

  void openLoginScreen(BuildContext context) {
    providerDispose();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ));
  }

  Future<void> signUp(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        var credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController!.text,
                password: passwordController!.text);
        if (credential.user != null) {
          await credential.user?.updateDisplayName(nameController!.text);
          providerDispose();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              ));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController!.text, password: passwordController!.text);
        providerDispose();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }
}
