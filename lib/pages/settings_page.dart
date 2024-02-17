import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:recipe/pages/register_profile_page.dart';
import 'package:recipe/pages/side_menu_page.dart';
import 'package:recipe/providers/settings_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/navigation.dart';
import 'package:recipe/utils/text_styles.dart';
import 'package:recipe/widgets/language_bottom_sheet_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ZoomDrawerController controller;

  @override
  void initState() {
    controller = ZoomDrawerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: controller,
      disableDragGesture: true,
      mainScreenTapClose: true,
      style: DrawerStyle.defaultStyle,
      menuBackgroundColor: Colors.white,
      borderRadius: 24.0.r,
      showShadow: true,
      angle: -12.0,
      drawerShadowsBackgroundColor: Colors.grey.shade300,
      slideWidth: MediaQuery.of(context).size.width * .65,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      menuScreen: const SideMenuPage(),
      mainScreen: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.toggle!();
            },
            icon: const Icon(
              Icons.sort,
              color: Colors.black,
            ),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
          title: Text(AppLocalizations.of(context)!.settings),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20).r,
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const LanguageBottomSheetWidget(),
                  );
                },
                tileColor: ColorsConst.containerBgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                leading: const Icon(CupertinoIcons.globe),
                title: Text(AppLocalizations.of(context)!.language),
                titleTextStyle: hellix14w500().copyWith(color: Colors.black87),
                trailing: Text(
                    Provider.of<SettingsProvider>(context).languageCode == "en"
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                    style: hellix14w400()),
              ),
              SizedBox(
                height: 10.h,
              ),
              ListTile(
                onTap: () {
                  Navigation.push(
                      context: context, page: const RegisterProfilePage());
                },
                tileColor: ColorsConst.containerBgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: const Icon(CupertinoIcons.person),
                title: Text(AppLocalizations.of(context)!.editProfile),
                titleTextStyle: hellix14w500().copyWith(color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
