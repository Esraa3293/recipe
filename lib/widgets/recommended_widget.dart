import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:recipe/models/recipe.model.dart';
import 'package:recipe/providers/recipes_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/numbers.dart';

class RecommendedWidget extends StatefulWidget {
  final Recipe? recipe;

  const RecommendedWidget({required this.recipe, super.key});

  @override
  State<RecommendedWidget> createState() => _RecommendedWidgetState();
}

class _RecommendedWidgetState extends State<RecommendedWidget> {
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
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: widget.recipe?.imagePath ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
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
                        textScaleFactor: .8,
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
                            unratedColor: ColorsConst.grayColor,
                            itemCount: 5,
                            itemSize: 15,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: ColorsConst.primaryColor,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.recipe?.nutFacts ?? "",
                            style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.normal,
                                color: ColorsConst.primaryColor),
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
                            widget.recipe?.prepTime ?? "",
                            style: const TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.normal,
                              color: ColorsConst.grayColor,
                            ),
                          ),
                          const SizedBox(
                            width: 17,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.room_service_outlined,
                                size: 20,
                                color: ColorsConst.grayColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${widget.recipe?.serving}  Serving",
                                textScaleFactor: .9,
                                style: const TextStyle(
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
                  Provider.of<RecipesProvider>(context, listen: false)
                      .addFavoriteToUser(
                          widget.recipe!.docId!,
                          !(widget.recipe!.favoriteUsersIds?.contains(
                                  FirebaseAuth.instance.currentUser?.uid) ??
                              false));
                },
                child: (widget.recipe!.favoriteUsersIds?.contains(
                            FirebaseAuth.instance.currentUser?.uid) ??
                        false
                    ? const Icon(
                        Icons.favorite_rounded,
                        color: ColorsConst.primaryColor,
                        size: 30,
                      )
                    : const Icon(
                        Icons.favorite_outline_rounded,
                        color: ColorsConst.grayColor,
                        size: 30,
                      ))),
          )
        ],
      ),
    );
  }
}
