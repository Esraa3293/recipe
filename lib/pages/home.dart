import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe/models/recipe.model.dart';
import 'package:recipe/pages/side_menu_page.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/images.dart';
import 'package:recipe/utils/numbers.dart';
import 'package:recipe/widgets/recipe_widget.dart';
import 'package:recipe/widgets/recommended_widget.dart';
import 'package:recipe/widgets/section_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController carouselController = CarouselController();

  List<RecipeWidget> recipes = [
    RecipeWidget(
      recipe: Recipe(
        imagePath: ImagesPath.meal3,
        title: "French Toast with Berries",
        numOfCalories: 120,
        prepTime: 10,
      ),
    ),
    RecipeWidget(
      recipe: Recipe(
        imagePath: ImagesPath.meal2,
        title: "Brown Sugar Cinnamon Toast",
        numOfCalories: 135,
        prepTime: 15,
      ),
    )
  ];
  List<RecommendedWidget> recommendedRecipes = [
    RecommendedWidget(
      recipe: Recipe(
        imagePath: ImagesPath.meal1,
        title: "Blueberry Muffins",
        mealType: "Breakfast",
        numOfCalories: 120,
        prepTime: 10,
      ),
    ),
    RecommendedWidget(
      recipe: Recipe(
        imagePath: ImagesPath.meal5,
        title: "Glazed Salmon",
        mealType: "Main Dish",
        numOfCalories: 280,
        prepTime: 45,
      ),
    ),
    RecommendedWidget(
      recipe: Recipe(
        imagePath: ImagesPath.meal4,
        title: "Asian Glazed Chicken Thighs",
        mealType: "Main Dish",
        numOfCalories: 280,
        prepTime: 45,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    String email = GetIt.I.get<SharedPreferences>().getString("email") ?? "";
    // String? email = PreferencesService.prefs?.getString("email") ?? "";
    return BlocProvider(
      create: (context) => HomeCubit()..getAds(),
      child: SafeArea(
        child: Scaffold(
          drawer: const DrawerWidget(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.sort,
                  color: Colors.black,
                ),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
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
          body: BlocConsumer<HomeCubit, HomeStates>(
            listener: (context, state) {},
            builder: (context, state) => HomeCubit.get(context).adsList.isEmpty
                ? const CircularProgressIndicator(color: ColorsConst.mainColor)
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Numbers.appHorizontalPadding),
                          child: Text(
                            "Bonjour, $email",
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
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10))),
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
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CarouselSlider(
                              carouselController: carouselController,
                              options: CarouselOptions(
                                height: 200.0,
                                autoPlay: true,
                                viewportFraction: .75,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                                enlargeCenterPage: true,
                                enlargeFactor: .3,
                                onPageChanged: (index, _) {
                                  HomeCubit.get(context)
                                      .changeSliderIndex(index);
                                },
                              ),
                              items: HomeCubit.get(context).adsList.map((ad) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Stack(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: NetworkImage(ad.image ?? ""),
                                            fit: BoxFit.fill,
                                          )),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(8.0),
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                              color: Colors.black38,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Text(
                                            ad.title ?? "",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await carouselController.previousPage();
                                  },
                                  icon: const Icon(Icons.arrow_back_ios),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await carouselController.nextPage();
                                  },
                                  icon: const Icon(Icons.arrow_forward_ios),
                                ),
                              ],
                            ),
                          ],
                        ),
                        DotsIndicator(
                          dotsCount: HomeCubit.get(context).adsList.length,
                          position: HomeCubit.get(context).sliderIndex,
                          onTap: (position) async {
                            await carouselController.animateToPage(position);
                          },
                          decorator: DotsDecorator(
                            activeColor: ColorsConst.mainColor,
                            size: const Size.square(9.0),
                            activeSize: const Size(18.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SectionHeader(
                            sectionName: "Today\'s Fresh Recipes"),
                        const SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                          height: 230,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => recipes[index],
                              separatorBuilder: (context, index) =>
                                  const VerticalDivider(
                                    color: Colors.transparent,
                                  ),
                              itemCount: recipes.length),
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
                            itemBuilder: (context, index) =>
                                recommendedRecipes[index],
                            separatorBuilder: (context, index) => const Divider(
                                  color: Colors.transparent,
                                ),
                            itemCount: recommendedRecipes.length)
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
