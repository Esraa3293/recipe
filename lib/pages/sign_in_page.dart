import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recipe/pages/forgot_password_page.dart';
import 'package:recipe/providers/app_auth_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/images.dart';
import 'package:recipe/utils/navigation.dart';
import 'package:recipe/utils/text_styles.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).init();
    super.initState();
  }

  // @override
  // void dispose() {
  //   Provider.of<AppAuthProvider>(context, listen: false).providerDispose();
  //   super.dispose();
  // }

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
          Container(
            color: Colors.black38,
            child: Padding(
              padding: const EdgeInsets.all(20.0).r,
              child: Consumer<AppAuthProvider>(
                builder: (context, authProvider, child) {
                  return Form(
                    key: authProvider.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50, right: 50, bottom: 25)
                              .r,
                          child: Image.asset(ImagesPath.baseHeader),
                        ),
                        Text(
                          "Sign In",
                          style: hellix18w700(),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20.h,
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
                          controller: authProvider.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
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
                          controller: authProvider.passwordController,
                          obscureText: authProvider.obsecureText,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: InkWell(
                                onTap: () {
                                  authProvider.toggleObsecure();
                                },
                                child: Icon(authProvider.obsecureText
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        InkWell(
                          onTap: () {
                            Navigation.push(
                                context: context,
                                page: const ForgotPasswordPage());
                          },
                          child: Text(
                            "Forgot Password",
                            style: hellix12w500()
                                .copyWith(color: ColorsConst.titleColor),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await authProvider.signIn(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsConst.primaryColor,
                            minimumSize: Size(20.w, 50.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          child: Text("Sign In",
                              style: hellix16white()
                                  .copyWith(fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  );
                },
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
            Text(
              "Don't have an account?",
              style: hellix14w500().copyWith(color: ColorsConst.grayColor),
            ),
            TextButton(
                onPressed: () {
                  Provider.of<AppAuthProvider>(context, listen: false)
                      .openSignUpScreen(context);
                },
                child: Text(
                  "Register",
                  style:
                      hellix14w500().copyWith(color: ColorsConst.primaryColor),
                )),
          ],
        ),
      ),
    );
  }
}
