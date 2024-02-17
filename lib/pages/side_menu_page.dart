import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:recipe/pages/about_us_page.dart';
import 'package:recipe/pages/favorites_page.dart';
import 'package:recipe/pages/home_page.dart';
import 'package:recipe/pages/ingredients_page.dart';
import 'package:recipe/pages/recently_viewed_page.dart';
import 'package:recipe/pages/register_profile_page.dart';
import 'package:recipe/pages/settings_page.dart';
import 'package:recipe/providers/app_auth_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/navigation.dart';
import 'package:recipe/utils/navigation_item.dart';
import 'package:recipe/utils/text_styles.dart';

class SideMenuPage extends StatefulWidget {
  const SideMenuPage({super.key});

  @override
  State<SideMenuPage> createState() => _SideMenuPageState();
}

class _SideMenuPageState extends State<SideMenuPage> {
  String? email = FirebaseAuth.instance.currentUser?.email ?? "";
  String? name = FirebaseAuth.instance.currentUser?.displayName ?? "";
  String? profilePic = FirebaseAuth.instance.currentUser?.photoURL;

  NavigationItem _navigationItem = NavigationItem.home;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(profilePic ??
                    "https://www.pngitem.com/pimgs/m/421-4212266_transparent-default-avatar-png-default-avatar-images-png.png"),
              ),
              title: Text(name ?? "", style: hellix16w500()),
              subtitle: InkWell(
                onTap: () {
                  Navigation.push(
                      context: context, page: const RegisterProfilePage());
                },
                child: Text(
                  AppLocalizations.of(context)!.viewProfile,
                  style: hellix12w500(),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                _navigationItem = NavigationItem.home;
                setState(() {});
                Navigation.push(context: context, page: const HomePage());
              },
              selected: _navigationItem == NavigationItem.home,
              leading: Icon(
                Icons.home,
                color: _navigationItem == NavigationItem.home
                    ? ColorsConst.primaryColor
                    : ColorsConst.grayColor,
              ),
              title: Text(
                AppLocalizations.of(context)!.home,
                style: TextStyle(
                    color: _navigationItem == NavigationItem.home
                        ? ColorsConst.primaryColor
                        : ColorsConst.grayColor),
              ),
            ),
            ListTile(
              onTap: () {
                _navigationItem = NavigationItem.favorites;
                setState(() {});
                Navigation.push(context: context, page: const FavoritesPage());
              },
              selected: _navigationItem == NavigationItem.favorites,
              leading: Icon(
                Icons.favorite_border_rounded,
                color: _navigationItem == NavigationItem.favorites
                    ? ColorsConst.primaryColor
                    : ColorsConst.grayColor,
              ),
              title: Text(
                AppLocalizations.of(context)!.favorites,
                style: TextStyle(
                    color: _navigationItem == NavigationItem.favorites
                        ? ColorsConst.primaryColor
                        : ColorsConst.grayColor),
              ),
            ),
            ListTile(
              onTap: () {
                _navigationItem = NavigationItem.recentlyViewed;
                setState(() {});
                Navigation.push(
                    context: context, page: const RecentlyViewedPage());
              },
              selected: _navigationItem == NavigationItem.recentlyViewed,
              leading: Icon(
                CupertinoIcons.play,
                color: _navigationItem == NavigationItem.recentlyViewed
                    ? ColorsConst.primaryColor
                    : ColorsConst.grayColor,
              ),
              title: Text(
                AppLocalizations.of(context)!.recentlyViewed,
                style: TextStyle(
                    color: _navigationItem == NavigationItem.recentlyViewed
                        ? ColorsConst.primaryColor
                        : ColorsConst.grayColor),
              ),
            ),
            ListTile(
              onTap: () {
                _navigationItem = NavigationItem.ingredients;
                setState(() {});
                Navigation.push(
                    context: context, page: const IngredientsPage());
              },
              selected: _navigationItem == NavigationItem.ingredients,
              leading: Icon(
                Icons.food_bank_outlined,
                color: _navigationItem == NavigationItem.ingredients
                    ? ColorsConst.primaryColor
                    : ColorsConst.grayColor,
              ),
              title: Text(
                AppLocalizations.of(context)!.ingredients,
                style: TextStyle(
                    color: _navigationItem == NavigationItem.ingredients
                        ? ColorsConst.primaryColor
                        : ColorsConst.grayColor),
              ),
            ),
            ListTile(
              onTap: () {
                _navigationItem = NavigationItem.settings;
                setState(() {});
                Navigation.push(context: context, page: const SettingsPage());
              },
              selected: _navigationItem == NavigationItem.settings,
              leading: Icon(
                Icons.settings_outlined,
                color: _navigationItem == NavigationItem.settings
                    ? ColorsConst.primaryColor
                    : ColorsConst.grayColor,
              ),
              title: Text(
                AppLocalizations.of(context)!.settings,
                style: TextStyle(
                    color: _navigationItem == NavigationItem.settings
                        ? ColorsConst.primaryColor
                        : ColorsConst.grayColor),
              ),
            ),
            ListTile(
              onTap: () {
                _navigationItem = NavigationItem.aboutUs;
                setState(() {});
                Navigation.push(context: context, page: const AboutUsPage());
              },
              selected: _navigationItem == NavigationItem.aboutUs,
              leading: Icon(
                Icons.info_outline_rounded,
                color: _navigationItem == NavigationItem.aboutUs
                    ? ColorsConst.primaryColor
                    : ColorsConst.grayColor,
              ),
              title: Text(
                AppLocalizations.of(context)!.aboutUs,
                style: TextStyle(
                    color: _navigationItem == NavigationItem.aboutUs
                        ? ColorsConst.primaryColor
                        : ColorsConst.grayColor),
              ),
            ),
            ListTile(
              onTap: () async {
                _navigationItem = NavigationItem.signOut;
                setState(() {});
                await Provider.of<AppAuthProvider>(context, listen: false)
                    .signOut(context);
              },
              selected: _navigationItem == NavigationItem.signOut,
              leading: Icon(
                Icons.logout,
                color: _navigationItem == NavigationItem.signOut
                    ? ColorsConst.primaryColor
                    : ColorsConst.grayColor,
              ),
              title: Text(
                AppLocalizations.of(context)!.signOut,
                style: TextStyle(
                    color: _navigationItem == NavigationItem.signOut
                        ? ColorsConst.primaryColor
                        : ColorsConst.grayColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
