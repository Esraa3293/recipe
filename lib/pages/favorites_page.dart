import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:recipe/models/recipe.model.dart';
import 'package:recipe/pages/filter_page.dart';
import 'package:recipe/pages/side_menu_page.dart';
import 'package:recipe/providers/recipes_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/numbers.dart';
import 'package:recipe/utils/text_styles.dart';
import 'package:recipe/widgets/animated_staggered_list_widget.dart';
import 'package:recipe/widgets/recommended_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Recipe> searchedList = [];
  late ZoomDrawerController controller;
  late TextEditingController searchController;

  void init() async {
    await Provider.of<RecipesProvider>(context, listen: false)
        .getFavoriteRecipes();
  }

  void searchFavorites(String searchedRecipe) {
    searchedList = Provider.of<RecipesProvider>(context, listen: false)
        .favoriteRecipes!
        .where(
            (recipe) => recipe.title!.toLowerCase().startsWith(searchedRecipe))
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    init();
    controller = ZoomDrawerController();
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: controller,
      disableDragGesture: true,
      mainScreenTapClose: true,
      style: DrawerStyle.defaultStyle,
      menuBackgroundColor: Colors.white,
      borderRadius: 24.0.r,
      showShadow: true,
      angle: -12.0,
      drawerShadowsBackgroundColor: Colors.grey.shade300,
      slideWidth: MediaQuery.of(context).size.width * .65,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      menuScreen: const SideMenuPage(),
      mainScreen: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.toggle!();
            },
            icon: const Icon(
              Icons.sort,
              color: Colors.black,
            ),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
          title: Text(
            AppLocalizations.of(context)!.favorites,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Numbers.appHorizontalPadding),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 265.w,
                      height: 35.h,
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search,
                              color: ColorsConst.grayColor,
                            ),
                            hintText: AppLocalizations.of(context)!.search,
                            hintStyle: hellix12w400(),
                            filled: true,
                            fillColor: ColorsConst.containerBgColor,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.r)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.r))),
                        onChanged: (searchedRecipe) {
                          searchFavorites(searchedRecipe);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FilterPage(),
                          ));
                    },
                    child: Container(
                      width: 35.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                          color: ColorsConst.containerBgColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: const Icon(Icons.tune),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('recipes')
                  .where("favoriteUsersIds",
                      arrayContains: FirebaseAuth.instance.currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshots) {
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshots.hasError) {
                  return const Center(child: Text("Something went wrong!"));
                } else if (snapshots.hasData) {
                  if (snapshots.data?.docs.isNotEmpty ?? false) {
                    List<Recipe> recipes = snapshots.data?.docs
                            .map((e) => Recipe.fromJson(e.data(), e.id))
                            .toList() ??
                        [];
                    return Expanded(
                      child: AnimationLimiter(
                        child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 10).r,
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemBuilder: (context, index) =>
                                AnimatedStaggeredList(
                                    widget: searchController.text.isEmpty
                                        ? RecommendedWidget(
                                            recipe: recipes[index])
                                        : RecommendedWidget(
                                            recipe: searchedList[index]),
                                    index: index),
                            separatorBuilder: (context, index) => const Divider(
                                  color: Colors.transparent,
                                ),
                            itemCount: searchController.text.isEmpty
                                ? recipes.length
                                : searchedList.length),
                      ),
                    );
                  } else {
                    return Center(
                        child: Text(
                      "No Favorite Recipes",
                      style: hellix16w500()
                          .copyWith(color: ColorsConst.primaryColor),
                    ));
                  }
                } else {
                  return const Center(child: Text("No Favorite Recipes"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
