import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/pages/favorites_page.dart';
import 'package:recipe/pages/home.dart';
import 'package:recipe/pages/ingredients_page.dart';
import 'package:recipe/providers/app_auth_provider.dart';
import 'package:recipe/utils/colors.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String? email = FirebaseAuth.instance.currentUser?.email ?? "";
  String? name = FirebaseAuth.instance.currentUser?.displayName ?? "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.jpeg"),
              ),
              title: Text(
                name ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                email ?? "",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // trailing: IconButton(
              //     onPressed: () {},
              //     icon: const Badge(child: Icon(Icons.notifications_none))),
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
                  color: ColorsConst.primaryColor,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(color: ColorsConst.primaryColor),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const IngredientsPage(),
                  ),
                );
              },
              child: const ListTile(
                leading: Icon(
                  Icons.food_bank_outlined,
                  color: ColorsConst.grayColor,
                ),
                title: Text(
                  "Ingredients",
                  style: TextStyle(color: ColorsConst.grayColor),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritesPage(),
                    ));
              },
              child: const ListTile(
                leading: Icon(
                  Icons.favorite_outline_rounded,
                  color: ColorsConst.grayColor,
                ),
                title: Text(
                  "Favorites",
                  style: TextStyle(color: ColorsConst.grayColor),
                ),
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
            Consumer<AppAuthProvider>(
              builder: (context, authProvider, child) {
                return InkWell(
                  onTap: () async {
                    await authProvider.signOut(context);
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
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
