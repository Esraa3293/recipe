import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipe/providers/recipes_provider.dart';
import 'package:recipe/utils/colors.dart';
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

  void init() async {
    // await Provider.of<RecipesProvider>(context, listen: false).getRecipes();
    await Provider.of<RecipesProvider>(context, listen: false)
        .getFreshRecipes();
    await Provider.of<RecipesProvider>(context, listen: false)
        .getRecommendedRecipes();
  }

  @override
  void initState() {
    init();
    controller = ZoomDrawerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    builder: (context, recipesProvider, child) =>
                        recipesProvider.freshRecipes == null
                            ? const Center(child: CircularProgressIndicator())
                            : (recipesProvider.recipes?.isEmpty ?? false)
                                ? const Center(
                                    child: Text(
                                      "No Data Found!",
                                      style: TextStyle(
                                          color: ColorsConst.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Numbers.appHorizontalPadding),
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) =>
                                            RecipeWidget(
                                                recipe: recipesProvider
                                                    .freshRecipes![index]),
                                        separatorBuilder: (context, index) =>
                                            const VerticalDivider(
                                              color: Colors.transparent,
                                            ),
                                        itemCount: recipesProvider
                                            .freshRecipes!.length),
                                  ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const SectionHeader(sectionName: "Recommended"),
                const SizedBox(
                  height: 10,
                ),
                Consumer<RecipesProvider>(
                  builder: (context, recipesProvider, child) =>
                      recipesProvider.freshRecipes == null
                          ? const Center(child: CircularProgressIndicator())
                          : (recipesProvider.recipes?.isEmpty ?? false)
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
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.only(bottom: 10),
                                  itemBuilder: (context, index) =>
                                      RecommendedWidget(
                                          recipe: recipesProvider
                                              .recommendedRecipes![index]),
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                        color: Colors.transparent,
                                      ),
                                  itemCount: recipesProvider
                                          .recommendedRecipes?.length ??
                                      0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
