import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe/pages/home.dart';
import 'package:recipe/pages/login.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/widgets/side_menu_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/numbers.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String? email = GetIt.I.get<SharedPreferences>().getString("email");

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Numbers.appHorizontalPadding),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20, right: 20),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.jpeg"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        email ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        "View Profile",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorsConst.grayColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: SideMenuWidget(
                icon: Icons.home,
                title: "Home",
                color: ColorsConst.mainColor,
              ),
            ),
            SideMenuWidget(
              icon: Icons.favorite_outline_rounded,
              title: "Favorites",
              color: ColorsConst.grayColor,
            ),
            SideMenuWidget(
              icon: CupertinoIcons.play,
              title: "Recently Viewed",
              color: ColorsConst.grayColor,
            ),
            SideMenuWidget(
              icon: Icons.settings_outlined,
              title: "Settings",
              color: ColorsConst.grayColor,
            ),
            SideMenuWidget(
              icon: Icons.info_outline_rounded,
              title: "About Us",
              color: ColorsConst.grayColor,
            ),
            SideMenuWidget(
              icon: Icons.help_outline,
              title: "Help",
              color: ColorsConst.grayColor,
            ),
            InkWell(
              onTap: () async {
                await GetIt.I.get<SharedPreferences>().remove("loggedIn");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
                setState(() {});
              },
              child: SideMenuWidget(
                icon: Icons.logout,
                title: "Sign Out",
                color: ColorsConst.grayColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
