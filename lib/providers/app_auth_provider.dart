import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:recipe/pages/home_page.dart';
import 'package:recipe/pages/sign_in_page.dart';
import 'package:recipe/pages/sign_up_page.dart';
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
          builder: (_) => const SignUpPage(),
        ));
  }

  void openLoginScreen(BuildContext context) {
    providerDispose();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SignInPage(),
        ));
  }

  Future<void> uploadImage() async {
    try {
      OverlayLoadingProgress.start();
      var imageResult = await FilePicker.platform
          .pickFiles(type: FileType.image, withData: true);
      var reference = FirebaseStorage.instance
          .ref('profile/${imageResult?.files.first.name}');
      if (imageResult?.files.first.bytes != null) {
        var uploadResult = await reference.putData(
            imageResult!.files.first.bytes!,
            SettableMetadata(contentType: 'image/png'));
        if (uploadResult.state == TaskState.success) {
          print(
              'Image Uploaded Successfully ${await reference.getDownloadURL()}');
        }
      }
      OverlayLoadingProgress.stop();
      // String downloadUrl = await reference.getDownloadURL();
      // return downloadUrl;
    } catch (e) {
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
    }
  }

  void updateProfileImage() async {
    try {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        await FirebaseAuth.instance.currentUser?.updatePhotoURL(
            "https://firebasestorage.googleapis.com/v0/b/recipe-a3645.appspot.com/o/profile%2FFB_IMG_1708094063787.jpg?alt=media&token=a943eada-483f-41da-a2d7-75e357b29002");
      }
    } catch (e) {
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
    }
    notifyListeners();
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
              message: 'Registered Successfully',
              toastMessageStatus: ToastMessageStatus.success,
            ),
          );
          if (context.mounted) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
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
              message: 'Signed In Successfully',
              toastMessageStatus: ToastMessageStatus.success,
            ),
          );
          if (context.mounted) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
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

  Future<void> verifyEmail() async {
    try {
      OverlayLoadingProgress.start();
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController!.text);
      OverlayToastMessage.show(
        widget: const ToastMessage(
          message: "Password Reset Email Sent",
          toastMessageStatus: ToastMessageStatus.success,
        ),
      );
      OverlayLoadingProgress.stop();
    } on FirebaseAuthException catch (e) {
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
      OverlayLoadingProgress.stop();
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
