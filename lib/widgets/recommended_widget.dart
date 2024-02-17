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
import 'package:recipe/utils/numbers.dart';
import 'package:recipe/utils/text_styles.dart';

class RecommendedWidget extends StatefulWidget {
  final Recipe? recipe;

  const RecommendedWidget({required this.recipe, super.key});

  @override
  State<RecommendedWidget> createState() => _RecommendedWidgetState();
}

class _RecommendedWidgetState extends State<RecommendedWidget> {
  @override
  Widget build(BuildContext context) {
    var rating = widget.recipe?.rate ?? 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Numbers.appHorizontalPadding),
      child: InkWell(
        onTap: () {
          Navigation.push(
              context: context,
              page: RecipeDetailsPage(recipe: widget.recipe!));
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: double.infinity,
              height: 100.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: ColorsConst.containerBgColor),
              child: Row(
                children: [
                  SizedBox(
                    width: 100.w,
                    height: 100.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: CachedNetworkImage(
                        imageUrl: widget.recipe?.imageUrl ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0).r,
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
                          textScaleFactor: .8,
                          style: hellix14w500(),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Row(
                          children: [
                            RatingBar.builder(
                              initialRating: rating.toDouble(),
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
                              onRatingUpdate: (value) {
                                value = rating.toDouble();
                                setState(() {});
                                print(value);
                              },
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "${widget.recipe?.calories} Calories",
                              style: hellix8w400(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 15,
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
                            SizedBox(
                              width: 17.w,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.room_service_outlined,
                                  size: 15,
                                  color: ColorsConst.grayColor,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "${widget.recipe?.serving}  Servings",
                                  textScaleFactor: .9,
                                  style: hellix8w400()
                                      .copyWith(color: ColorsConst.grayColor),
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
            Positioned(
              top: 6,
              right: 8,
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
      ),
    );
  }
}
