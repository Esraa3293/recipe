import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:recipe/pages/home.dart';
import 'package:recipe/pages/login.dart';
import 'package:recipe/pages/sign_up.dart';
import 'package:recipe/pages/splash_screen.dart';
import 'package:recipe/utils/toast_message_status.dart';
import 'package:recipe/widgets/toast_message_widget.dart';

class AppAuthProvider extends ChangeNotifier {
  GlobalKey<FormState>? formKey;
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool obsecureText = true;

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
    obsecureText = true;
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
        OverlayLoadingProgress.start();
        var credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController!.text,
                password: passwordController!.text);
        if (credential.user != null) {
          await credential.user?.updateDisplayName(nameController!.text);
          OverlayLoadingProgress.stop();
          providerDispose();
          OverlayToastMessage.show(
            widget: const ToastMessage(
              message: 'Successfully Registered',
              toastMessageStatus: ToastMessageStatus.success,
            ),
          );
          if (context.mounted) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
          }
        }
        OverlayLoadingProgress.stop();
      }
    } on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();
      if (e.code == 'email-already-in-use') {
        OverlayToastMessage.show(
          widget: const ToastMessage(
            message: 'The account already exists for that email.',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      } else if (e.code == 'weak-password') {
        OverlayToastMessage.show(
          widget: const ToastMessage(
            message: 'The password provided is too weak.',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      print(e);
    }
  }

  Future<void> signIn(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        OverlayLoadingProgress.start();
        var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController!.text, password: passwordController!.text);
        if (credential.user != null) {
          OverlayLoadingProgress.stop();
          providerDispose();
          OverlayToastMessage.show(
            widget: const ToastMessage(
              message: 'Successfully Signed In',
              toastMessageStatus: ToastMessageStatus.success,
            ),
          );
          if (context.mounted) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
          }
        }
        OverlayLoadingProgress.stop();
      }
    } on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();
      if (e.code == 'user-not-found') {
        OverlayToastMessage.show(
          widget: const ToastMessage(
            message: 'No user found for that email',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      } else if (e.code == 'wrong-password') {
        OverlayToastMessage.show(
          widget: const ToastMessage(
            message: 'wrong password',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      } else if (e.code == 'user-disabled') {
        OverlayToastMessage.show(
          widget: const ToastMessage(
            message: 'this email account was disabled',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      } else if (e.code == 'invalid-credential') {
        OverlayToastMessage.show(
          widget: const ToastMessage(
            message: 'invalid credential',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      print(e);
    }
  }

  Future<void> signOut(BuildContext context) async {
    OverlayLoadingProgress.start();
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          ),
          (route) => false);
    }
    OverlayLoadingProgress.stop();
  }
}
