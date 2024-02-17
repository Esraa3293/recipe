import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recipe/pages/all_recipes_page.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/navigation.dart';
import 'package:recipe/utils/numbers.dart';
import 'package:recipe/utils/text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String sectionName;

  const SectionHeader({required this.sectionName, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Numbers.appHorizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            sectionName,
            style: hellix18w700().copyWith(color: Colors.black),
          ),
          InkWell(
            onTap: () {
              Navigation.push(context: context, page: const AllRecipesPage());
            },
            child: Text(
              AppLocalizations.of(context)!.seeAll,
              style: hellix14w500().copyWith(color: ColorsConst.primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
