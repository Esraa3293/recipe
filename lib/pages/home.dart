import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipe/models/recipe.model.dart';
import 'package:recipe/providers/recipes_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/images.dart';
import 'package:recipe/utils/numbers.dart';
import 'package:recipe/widgets/ads_widget.dart';
import 'package:recipe/widgets/recipe_widget.dart';
import 'package:recipe/widgets/recommended_widget.dart';
import 'package:recipe/widgets/section_header.dart';
import 'package:recipe/widgets/side_menu_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ZoomDrawerController controller;
  List<RecommendedWidget> recommendedRecipes = [
    RecommendedWidget(
      recipe: Recipe(
        imagePath: ImagesPath.meal1,
        title: "Blueberry Muffins",
        mealType: "Breakfast",
        nutFacts: "120",
        prepTime: "10",
      ),
    ),
    RecommendedWidget(
      recipe: Recipe(
        imagePath: ImagesPath.meal5,
        title: "Glazed Salmon",
        mealType: "Main Dish",
        nutFacts: "280",
        prepTime: "45",
      ),
    ),
    RecommendedWidget(
      recipe: Recipe(
        imagePath: ImagesPath.meal4,
        title: "Asian Glazed Chicken Thighs",
        mealType: "Main Dish",
        nutFacts: "280",
        prepTime: "45",
      ),
    ),
  ];

  void init() async {
    await Provider.of<RecipesProvider>(context, listen: false).getRecipes();
  }

  @override
  void initState() {
    init();
    controller = ZoomDrawerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<RecipeWidget>? recipes = Provider.of<RecipesProvider>(context)
        .recipes
        ?.map((recipe) => RecipeWidget(
              recipe: recipe,
            ))
        .toList();
    String name = FirebaseAuth.instance.currentUser?.displayName ?? "";
    // String? email = PreferencesService.prefs?.getString("email") ?? "";
    return ZoomDrawer(
      controller: controller,
      disableDragGesture: true,
      mainScreenTapClose: true,
      style: DrawerStyle.defaultStyle,
      menuBackgroundColor: Colors.white,
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      drawerShadowsBackgroundColor: Colors.grey.shade300,
      slideWidth: MediaQuery.of(context).size.width * .65,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      menuScreen: const DrawerWidget(),
      mainScreen: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
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
            actions: const [
              Padding(
                padding: EdgeInsets.only(top: 16.0, right: 20.0),
                child: Badge(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.notifications_none,
                      color: Colors.black,
                    )),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Numbers.appHorizontalPadding),
                  child: Text(
                    "Bonjour, $name",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorsConst.grayColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Numbers.appHorizontalPadding),
                  child: Text(
                    "What would you like to cook today?",
                    style: GoogleFonts.abrilFatface(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Numbers.appHorizontalPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 265,
                          height: 35,
                          child: TextField(
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: ColorsConst.grayColor,
                                ),
                                hintText: "Search for recipes",
                                hintStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: ColorsConst.grayColor),
                                filled: true,
                                fillColor: ColorsConst.containerBgColor,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: ColorsConst.containerBgColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.tune),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const AdsWidget(),
                const SizedBox(
                  height: 15,
                ),
                const SectionHeader(sectionName: "Today\'s Fresh Recipes"),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  height: 230,
                  child: Consumer<RecipesProvider>(
                    builder: (context, recipeProvider, child) =>
                        recipeProvider.recipes == null
                            ? const Center(child: CircularProgressIndicator())
                            : (recipeProvider.recipes?.isEmpty ?? false)
                                ? const Center(
                                    child: Text(
                                      "No Data Found!",
                                      style: TextStyle(
                                          color: ColorsConst.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        recipes[index],
                                    separatorBuilder: (context, index) =>
                                        const VerticalDivider(
                                          color: Colors.transparent,
                                        ),
                                    itemCount: recipes!.length),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const SectionHeader(sectionName: "Recommended"),
                const SizedBox(
                  height: 10,
                ),
                ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 10),
                    itemBuilder: (context, index) => recommendedRecipes[index],
                    separatorBuilder: (context, index) => const Divider(
                          color: Colors.transparent,
                        ),
                    itemCount: recommendedRecipes.length)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
