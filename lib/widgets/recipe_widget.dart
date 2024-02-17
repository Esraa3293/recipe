import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recipe/models/recipe.model.dart';
import 'package:recipe/pages/recipe_details_page.dart';
import 'package:recipe/providers/recipes_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/navigation.dart';
import 'package:recipe/utils/text_styles.dart';

class RecipeWidget extends StatefulWidget {
  final Recipe? recipe;

  const RecipeWidget({required this.recipe, super.key});

  @override
  State<RecipeWidget> createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  @override
  Widget build(BuildContext context) {
    var rating = widget.recipe?.rate ?? 1;

    return InkWell(
      onTap: () {
        Navigation.push(
            context: context, page: RecipeDetailsPage(recipe: widget.recipe));
      },
      child: Stack(
        children: [
          Container(
            width: 160.w,
            height: 230.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: ColorsConst.containerBgColor),
            child: Column(
              children: [
                SizedBox(
                  width: 160.w,
                  height: 105.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.recipe?.imageUrl ?? "",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.recipe?.mealType ?? "",
                        style: hellix8w500(),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        widget.recipe?.title ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: hellix14w500(),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      RatingBar.builder(
                        initialRating: rating.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        unratedColor: ColorsConst.grayColor,
                        itemCount: 5,
                        itemSize: 10,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: ColorsConst.primaryColor,
                        ),
                        onRatingUpdate: (value) {
                          value = rating.toDouble();
                          setState(() {});
                          print(value);
                        },
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Text(
                        "${widget.recipe?.calories} Calories",
                        style: hellix8w400(),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 10,
                            color: ColorsConst.grayColor,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "${widget.recipe?.prepTime}  mins",
                            style: hellix8w400()
                                .copyWith(color: ColorsConst.grayColor),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.room_service_outlined,
                            size: 10,
                            color: ColorsConst.grayColor,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "${widget.recipe?.serving ?? 0}  Servings",
                            style: hellix8w400()
                                .copyWith(color: ColorsConst.grayColor),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 6,
            left: 6,
            child: InkWell(
                onTap: () {
                  Provider.of<RecipesProvider>(context, listen: false)
                      .addFavoriteToUser(
                          widget.recipe!.docId!,
                          !(widget.recipe!.favoriteUsersIds?.contains(
                                  FirebaseAuth.instance.currentUser?.uid) ??
                              false));
                },
                child: (widget.recipe?.favoriteUsersIds?.contains(
                            FirebaseAuth.instance.currentUser?.uid) ??
                        false
                    ? const Icon(
                        Icons.favorite_rounded,
                        size: 30,
                        color: ColorsConst.primaryColor,
                      )
                    : const Icon(
                        Icons.favorite_outline_rounded,
                        size: 30,
                        color: ColorsConst.grayColor,
                      ))),
          ),
        ],
      ),
    );
  }
}
