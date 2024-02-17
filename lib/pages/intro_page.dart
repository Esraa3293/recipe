import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/pages/sign_in_page.dart';
import 'package:recipe/pages/sign_up_page.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/images.dart';
import 'package:recipe/utils/text_styles.dart';
import 'package:recipe/widgets/button_widget.dart';

class IntroPage extends StatelessWidget {
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
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20).r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .2,
                  child: Image.asset(ImagesPath.baseHeader),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Cooking Done The Easy Way",
                  style: hellix14w400().copyWith(color: ColorsConst.grayColor),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                ButtonWidget(
                  MaterialPageRoute(
                    builder: (context) => const SignUpPage(),
                  ),
                  "Register",
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInPage(),
                          ));
                    },
                    child: Text(
                      "Sign In",
                      style:
                          hellix16white().copyWith(fontWeight: FontWeight.w600),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
