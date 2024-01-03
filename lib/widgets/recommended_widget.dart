import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipe/models/recipe.model.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/numbers.dart';

class RecommendedWidget extends StatefulWidget {
  Recipe? recipe = const Recipe();

  RecommendedWidget({this.recipe, super.key});

  @override
  State<RecommendedWidget> createState() => _RecommendedWidgetState();
}

class _RecommendedWidgetState extends State<RecommendedWidget> {
  bool favorite = false;

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
                  child: Image.asset(widget.recipe?.imagePath ?? ""),
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
                        widget.recipe?.mealType ?? "",
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
                        widget.recipe?.title ?? "",
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
                          RatingBar.builder(
                            initialRating: 3,
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
                            width: 8,
                          ),
                          Text(
                            "${widget.recipe?.numOfCalories ?? ""} Calories",
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
                            "${widget.recipe?.prepTime ?? ""} mins",
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
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                    )),
            ),
          )
        ],
      ),
    );
  }
}
