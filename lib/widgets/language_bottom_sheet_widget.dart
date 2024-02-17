import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recipe/providers/settings_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/text_styles.dart';

class LanguageBottomSheetWidget extends StatelessWidget {
  const LanguageBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) => Container(
        margin: const EdgeInsets.all(20).r,
        height: 200.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () {
                  settingsProvider.changeLanguage("en");
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.english,
                  style: settingsProvider.languageCode == "en"
                      ? hellix16w500()
                      : hellix16w500().copyWith(color: ColorsConst.grayColor),
                )),
            TextButton(
                onPressed: () {
                  settingsProvider.changeLanguage("ar");
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)!.arabic,
                  style: settingsProvider.languageCode == "ar"
                      ? hellix16w500()
                      : hellix16w500().copyWith(color: ColorsConst.grayColor),
                )),
          ],
        ),
      ),
    );
  }
}
