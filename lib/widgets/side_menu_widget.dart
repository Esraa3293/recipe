import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe/pages/home.dart';
import 'package:recipe/pages/login.dart';
import 'package:recipe/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String? email = GetIt.I.get<SharedPreferences>().getString("email");
  String? name = GetIt.I.get<SharedPreferences>().getString("name");

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Flexible(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.jpeg"),
              ),
              accountName: Text(
                name ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              accountEmail: Text(
                email ?? "",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
              child: const ListTile(
                leading: Icon(
                  Icons.home,
                  color: ColorsConst.mainColor,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(color: ColorsConst.mainColor),
                ),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.favorite_outline_rounded,
                color: ColorsConst.grayColor,
              ),
              title: Text(
                "Favorites",
                style: TextStyle(color: ColorsConst.grayColor),
              ),
            ),
            const ListTile(
              leading: Icon(
                CupertinoIcons.play,
                color: ColorsConst.grayColor,
              ),
              title: Text(
                "Recently Viewed",
                style: TextStyle(color: ColorsConst.grayColor),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.settings_outlined,
                color: ColorsConst.grayColor,
              ),
              title: Text(
                "Settings",
                style: TextStyle(color: ColorsConst.grayColor),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.info_outline_rounded,
                color: ColorsConst.grayColor,
              ),
              title: Text(
                "About Us",
                style: TextStyle(color: ColorsConst.grayColor),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.help_outline,
                color: ColorsConst.grayColor,
              ),
              title: Text(
                "Help",
                style: TextStyle(color: ColorsConst.grayColor),
              ),
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
              child: const ListTile(
                leading: Icon(
                  Icons.logout,
                  color: ColorsConst.grayColor,
                ),
                title: Text(
                  "Sign Out",
                  style: TextStyle(color: ColorsConst.grayColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
