import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recipe/providers/app_auth_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/text_styles.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.resetPassword),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).r,
        child: Consumer<AppAuthProvider>(
          builder: (context, authProvider, child) => Form(
            key: authProvider.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.resetPassEmail,
                  style: hellix16w500(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20.h,
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
                  controller: authProvider.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: hellix14w400().copyWith(color: Colors.black54),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await authProvider.verifyEmail();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsConst.primaryColor,
                    minimumSize: Size(20.w, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  icon: const Icon(
                    Icons.email_outlined,
                    color: Colors.white,
                  ),
                  label: Text(AppLocalizations.of(context)!.resetPassword,
                      style: hellix16white()
                          .copyWith(fontWeight: FontWeight.w600)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
