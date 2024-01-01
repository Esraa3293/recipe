import 'package:flutter/material.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/numbers.dart';

class RecipeWidget extends StatelessWidget {
  final Color? color1;
  final Color? color2;
  final String imagePath;
  final String title;
  final int numOfCalories;
  final int prepTime;
  final Icon icon;

  const RecipeWidget(
      {required this.imagePath,
      required this.title,
      required this.numOfCalories,
      required this.prepTime,
      required this.icon,
      required this.color1,
      required this.color2,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Numbers.appHorizontalPadding),
      child: Stack(
        children: [
          Container(
            width: 160,
            height: 230,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorsConst.containerBgColor),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 160,
                    height: 86,
                    child: Image.asset(imagePath),
                  ),
                  const Text(
                    "Breakfast",
                    style: TextStyle(
                      color: ColorsConst.titleColor,
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: color1,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: color1,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: color1,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: color1,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: color2,
                        size: 15,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Text(
                    "120 Calories",
                    style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.normal,
                        color: ColorsConst.mainColor),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 20,
                        color: ColorsConst.grayColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "$prepTime mins",
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                          color: ColorsConst.grayColor,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.room_service_outlined,
                        size: 20,
                        color: ColorsConst.grayColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "1 Serving",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                          color: ColorsConst.grayColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(4.0), child: icon),
        ],
      ),
    );
  }
}
