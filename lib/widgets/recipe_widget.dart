import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:recipe/models/recipe.model.dart';
import 'package:recipe/providers/recipes_provider.dart';
import 'package:recipe/utils/colors.dart';

class RecipeWidget extends StatefulWidget {
  final Recipe? recipe;

  const RecipeWidget({required this.recipe, super.key});

  @override
  State<RecipeWidget> createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 160,
          height: 230,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorsConst.containerBgColor),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 160,
                height: 105,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.recipe?.imagePath ?? "",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                      height: 7,
                    ),
                    Text(
                      widget.recipe?.nutFacts ?? "",
                      style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                          color: ColorsConst.primaryColor),
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
                        const Spacer(),
                        const Icon(
                          Icons.room_service_outlined,
                          size: 20,
                          color: ColorsConst.grayColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${widget.recipe?.serving ?? 0}",
                          style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.normal,
                            color: ColorsConst.grayColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
              onTap: () {
                Provider.of<RecipesProvider>(context, listen: false)
                    .addFavoriteToUser(
                        widget.recipe!.docId!,
                        !(widget.recipe!.favoriteUsersIds?.contains(
                                FirebaseAuth.instance.currentUser?.uid) ??
                            false));
              },
              child: (widget.recipe?.favoriteUsersIds
                          ?.contains(FirebaseAuth.instance.currentUser?.uid) ??
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
    );
  }
}
