import 'package:flutter/material.dart';
import 'package:recipe/models/recipe.model.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/numbers.dart';

class RecommendedWidget extends StatelessWidget {
  Recipe? recipe = const Recipe();

  RecommendedWidget({this.recipe, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Numbers.appHorizontalPadding),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorsConst.containerBgColor),
            child: Row(
              children: [
                SizedBox(
                  width: 75,
                  height: 45,
                  child: Image.asset(recipe?.imagePath ?? ""),
                ),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe?.mealType ?? "",
                        style: const TextStyle(
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
                            color: recipe?.color2,
                            size: 15,
                          ),
                          Icon(
                            Icons.star,
                            color: recipe?.color2,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "${recipe?.numOfCalories ?? ""} Calories",
                            style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.normal,
                                color: ColorsConst.mainColor),
                          ),
                        ],
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
                          const SizedBox(
                            width: 17,
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.room_service_outlined,
                                size: 20,
                                color: ColorsConst.grayColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "1 Serving",
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.normal,
                                  color: ColorsConst.grayColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.favorite_border,
              color: ColorsConst.grayColor,
            ),
          )
        ],
      ),
    );
  }
}
