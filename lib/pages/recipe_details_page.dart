import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recipe/models/ingredient.model.dart';
import 'package:recipe/models/recipe.model.dart';
import 'package:recipe/providers/recipes_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/text_styles.dart';
import 'package:recipe/widgets/details_header_widget.dart';

class RecipeDetailsPage extends StatefulWidget {
  final Recipe? recipe;

  const RecipeDetailsPage({required this.recipe, super.key});

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  bool get isInList =>
      widget.recipe?.favoriteUsersIds
          ?.contains(FirebaseAuth.instance.currentUser?.uid) ??
      false;

  void init() async {
    await Provider.of<RecipesProvider>(context, listen: false)
        .addRecentlyViewedRecipeToUser(widget.recipe!.docId!);
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var rating = widget.recipe?.rate ?? 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.recipeDetails,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).r,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.recipe?.mealType ?? "",
                  style:
                      hellix12w500().copyWith(color: ColorsConst.titleColor)),
              ListTile(
                  contentPadding: const EdgeInsets.all(0).r,
                  leading: Text(widget.recipe?.title ?? "",
                      textScaleFactor: 0.8, style: arbilFatface20()),
                  trailing: IconButton(
                    onPressed: () {
                      Provider.of<RecipesProvider>(context, listen: false)
                          .addFavoriteToUser(widget.recipe!.docId!, !isInList);
                      isInList
                          ? widget.recipe?.favoriteUsersIds
                              ?.remove(FirebaseAuth.instance.currentUser?.uid)
                          : widget.recipe?.favoriteUsersIds
                              ?.add(FirebaseAuth.instance.currentUser!.uid);
                      setState(() {});
                    },
                    icon: isInList
                        ? const Icon(
                            Icons.favorite_rounded,
                            size: 28,
                            color: ColorsConst.primaryColor,
                          )
                        : const Icon(
                            Icons.favorite_border_rounded,
                            size: 28,
                            color: ColorsConst.grayColor,
                          ),
                  )),
              SizedBox(
                height: 12.h,
              ),
              Text(
                "${widget.recipe?.calories} Calories",
                style: hellix12w400().copyWith(color: ColorsConst.primaryColor),
              ),
              SizedBox(
                height: 11.h,
              ),
              RatingBar.builder(
                initialRating: rating.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                unratedColor: ColorsConst.grayColor,
                itemCount: 5,
                itemSize: 20,
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
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(0).r,
                          iconColor: ColorsConst.grayColor,
                          textColor: ColorsConst.grayColor,
                          leading: const Icon(Icons.access_time),
                          title: Text("${widget.recipe?.prepTime}  mins"),
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.all(0).r,
                          iconColor: ColorsConst.grayColor,
                          textColor: ColorsConst.grayColor,
                          leading: const Icon(Icons.room_service_outlined),
                          title: Text("${widget.recipe?.serving}  Servings"),
                        ),
                      ],
                    ),
                  ),
                  CachedNetworkImage(
                    imageUrl: widget.recipe?.imageUrl ?? "",
                    width: 150.w,
                    height: 150.h,
                  )
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              DetailsHeader(title: AppLocalizations.of(context)!.description),
              SizedBox(
                height: 20.h,
              ),
              Text(widget.recipe?.description ?? ""),
              SizedBox(
                height: 25.h,
              ),
              DetailsHeader(title: AppLocalizations.of(context)!.ingredients),
              SizedBox(
                height: 20.h,
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('ingredients')
                    .where("users_ids",
                        arrayContains: FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong!'));
                  } else if (snapshot.hasData) {
                    if (snapshot.data?.docs.isNotEmpty ?? false) {
                      var userIngredients = snapshot.data!.docs
                          .map((doc) => Ingredient.fromJson(doc.data(), doc.id))
                          .toList();
                      var userIngredientsTitles =
                          userIngredients.map((e) => e.name).toList();
                      Widget checkIngredientWidget(String recipeIngredient) {
                        bool isExist = false;
                        for (var userIngredientsTitle
                            in userIngredientsTitles) {
                          if (recipeIngredient
                              .contains(userIngredientsTitle!.toLowerCase())) {
                            isExist = true;
                            break;
                          } else {
                            isExist = false;
                          }
                        }
                        if (isExist) {
                          return const Icon(
                            Icons.check,
                            color: Colors.green,
                          );
                        } else {
                          return const Icon(
                            Icons.close,
                            color: Colors.red,
                          );
                        }
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Row(
                          children: [
                            Flexible(
                                child:
                                    Text(widget.recipe?.ingred?[index] ?? "")),
                            SizedBox(
                              width: 20.w,
                            ),
                            checkIngredientWidget(
                                widget.recipe?.ingred?[index] ?? "")
                          ],
                        ),
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.transparent,
                        ),
                        itemCount: widget.recipe?.ingred?.length ?? 0,
                      );
                    } else {
                      return const Center(child: Text("No Data Found!"));
                    }
                  } else {
                    return const Center(child: Text("No Data Found!"));
                  }
                },
              ),
              SizedBox(
                height: 25.h,
              ),
              DetailsHeader(title: AppLocalizations.of(context)!.directions),
              SizedBox(
                height: 20.h,
              ),
              ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 10).r,
                itemBuilder: (context, index) =>
                    Text(widget.recipe?.directions![index] ?? ""),
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.transparent,
                ),
                itemCount: widget.recipe!.directions?.length ?? 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
