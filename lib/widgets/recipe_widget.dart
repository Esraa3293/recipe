import 'package:flutter/material.dart';
import 'package:recipe/models/recipe.model.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/numbers.dart';

class RecipeWidget extends StatelessWidget {
  Recipe? recipe = const Recipe();

  RecipeWidget({this.recipe, super.key});

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
                  Transform.translate(
                    offset: const Offset(40, 0),
                    child: Image.asset(
                      recipe?.imagePath ?? "",
                      fit: BoxFit.cover,
                      width: 160,
                      height: 86,
                    ),
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
                    recipe?.title ?? "",
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
                        color: recipe?.color1,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: recipe?.color1,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: recipe?.color1,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: recipe?.color1,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: recipe?.color2,
                        size: 15,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "${recipe?.numOfCalories ?? ""} Calories",
                    style: const TextStyle(
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
                        "${recipe?.prepTime ?? ""} mins",
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
          Padding(padding: const EdgeInsets.all(4.0), child: recipe?.icon),
        ],
      ),
    );
  }
}
