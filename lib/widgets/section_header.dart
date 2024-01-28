import 'package:flutter/material.dart';
import 'package:recipe/pages/all_recipes_page.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/numbers.dart';

class SectionHeader extends StatelessWidget {
  final String sectionName;

  const SectionHeader({required this.sectionName, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Numbers.appHorizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            sectionName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllRecipesPage(),
                  ));
            },
            child: const Text(
              "See All",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorsConst.primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
