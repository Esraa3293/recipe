import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recipe/providers/app_auth_provider.dart';
import 'package:recipe/utils/text_styles.dart';

class RegisterProfilePage extends StatefulWidget {
  const RegisterProfilePage({super.key});

  @override
  State<RegisterProfilePage> createState() => _RegisterProfilePageState();
}

class _RegisterProfilePageState extends State<RegisterProfilePage> {
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
    String? profilePic = FirebaseAuth.instance.currentUser?.photoURL;
    String? userName = FirebaseAuth.instance.currentUser?.displayName ?? "";
    String? email = FirebaseAuth.instance.currentUser?.email ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.registerPro),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 64.r,
                  backgroundImage: NetworkImage(
                      profilePic ??
                          "https://www.pngitem.com/pimgs/m/421-4212266_transparent-default-avatar-png-default-avatar-images-png.png",
                      scale: 1.0),
                ),
                Positioned(
                  bottom: -10.r,
                  right: 0.r,
                  child: IconButton(
                      onPressed: () async {
                        await Provider.of<AppAuthProvider>(context,
                                listen: false)
                            .uploadImage();
                        if (context.mounted) {
                          Provider.of<AppAuthProvider>(context, listen: false)
                              .updateProfileImage();
                        }
                      },
                      icon: const Icon(Icons.add_a_photo)),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: const EdgeInsets.all(10).r,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.black38)),
              child: Text(
                userName,
                style: hellix20w700().copyWith(color: Colors.black54),
              ),
            ),
            // SizedBox(
            //   height: 20.h,
            // ),
            // Container(
            //   padding: const EdgeInsets.all(10).r,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10.r),
            //       border: Border.all(color: Colors.black38)),
            //   child: Text(
            //     email,
            //     style: hellix20w700().copyWith(color: Colors.black54),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
