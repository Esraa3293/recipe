import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipe/models/recipe.model.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/numbers.dart';

class RecipeWidget extends StatefulWidget {
  Recipe? recipe = Recipe();

  RecipeWidget({this.recipe, super.key});

  @override
  State<RecipeWidget> createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  bool favorite = true;

  void toggleFavorite() {
    favorite = !favorite;
    setState(() {});
  }

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
                      widget.recipe?.imagePath ?? "",
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
                    widget.recipe?.title ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  RatingBar.builder(
                    initialRating: 4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    updateOnDrag: true,
                    unratedColor: ColorsConst.grayColor,
                    itemCount: 5,
                    itemSize: 15,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: ColorsConst.mainColor,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "${widget.recipe?.numOfCalories ?? ""} Calories",
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
                        "${widget.recipe?.prepTime ?? ""} mins",
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
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
                onTap: () {
                  toggleFavorite();
                },
                child: (favorite
                    ? const Icon(
                        Icons.favorite_border,
                        color: ColorsConst.grayColor,
                      )
                    : const Icon(
                        Icons.favorite,
                        color: ColorsConst.mainColor,
                      ))),
          ),
        ],
      ),
    );
  }
}
