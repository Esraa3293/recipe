import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe/models/ad.model.dart';
import 'package:recipe/pages/login.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/images.dart';
import 'package:recipe/utils/numbers.dart';
import 'package:recipe/widgets/recipe_widget.dart';
import 'package:recipe/widgets/recommended_widget.dart';
import 'package:recipe/widgets/section_header.dart';

import '../services/preferences.service.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int sliderIndex = 0;
  CarouselController carouselController = CarouselController();

  List<Ad> adsList = [];

  void getAds() async {
    var adsData = await rootBundle.loadString("assets/data/sample.json");
    var decodedData =
        List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);
    adsList = decodedData.map((e) => Ad.fromJson(e)).toList();
    setState(() {});
  }

  @override
  void initState() {
    getAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? email = PreferencesService.prefs?.getString("email") ?? "";
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            // title: Text("Welcome $email"),
            leading: const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Numbers.appHorizontalPadding),
              child: Icon(
                Icons.sort,
                color: Colors.black,
              ),
            ),
            actions: [
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Badge(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.notifications_none,
                      color: Colors.black,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Numbers.appHorizontalPadding),
                child: IconButton(
                  onPressed: () async {
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                    await PreferencesService.prefs?.remove("loggedIn");
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          body: adsList.isEmpty
              ? const CircularProgressIndicator(
                  color: Colors.deepOrange,
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Numbers.appHorizontalPadding),
                        child: Text(
                          "Bonjour, Emma",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: ColorsConst.grayColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Numbers.appHorizontalPadding),
                        child: Text(
                          "What would you like to cook today?",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              enlargeCenterPage: true,
                              enlargeFactor: .3,
                              onPageChanged: (index, _) {
                                sliderIndex = index;
                                setState(() {});
                              },
                            ),
                            items: adsList.map((ad) {
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
                        dotsCount: adsList.length,
                        position: sliderIndex,
                        onTap: (position) async {
                          await carouselController.animateToPage(position);
                          sliderIndex = position;
                          setState(() {});
                        },
                        decorator: DotsDecorator(
                          activeColor: Colors.deepOrange,
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Numbers.appHorizontalPadding),
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
                      const SizedBox(
                        height: 25,
                      ),
                      const SectionHeader(
                          sectionName: "Today\'s Fresh Recipes"),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          RecipeWidget(
                              imagePath: ImagesPath.meal3,
                              title: "French Toast with Berries",
                              numOfCalories: 120,
                              prepTime: 10,
                              color1: ColorsConst.mainColor,
                              color2: ColorsConst.mainColor,
                              icon: const Icon(
                                Icons.favorite_border,
                                color: ColorsConst.grayColor,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          RecipeWidget(
                              imagePath: ImagesPath.meal2,
                              title: "Brown Sugar Cinnamon Toast",
                              numOfCalories: 135,
                              prepTime: 15,
                              icon: const Icon(
                                Icons.favorite,
                                color: ColorsConst.mainColor,
                              ),
                              color1: ColorsConst.mainColor,
                              color2: ColorsConst.grayColor),
                        ],
                      ),
                      const SizedBox(
                        height: 33,
                      ),
                      const SectionHeader(sectionName: "Recommended"),
                      const SizedBox(
                        height: 10,
                      ),
                      RecommendedWidget(
                          imagePath: ImagesPath.meal1,
                          title: "Blueberry Muffins",
                          mealType: "Breakfast",
                          numOfCalories: 120,
                          prepTime: 10,
                          color1: ColorsConst.mainColor,
                          color2: ColorsConst.grayColor),
                      const SizedBox(
                        height: 10,
                      ),
                      RecommendedWidget(
                          imagePath: ImagesPath.meal5,
                          title: "Glazed Salmon",
                          mealType: "Main Dish",
                          numOfCalories: 280,
                          prepTime: 45,
                          color1: ColorsConst.mainColor,
                          color2: ColorsConst.mainColor),
                      const SizedBox(
                        height: 10,
                      ),
                      RecommendedWidget(
                          imagePath: ImagesPath.meal4,
                          title: "Asian Glazed Chicken Thighs",
                          mealType: "Main Dish",
                          numOfCalories: 280,
                          prepTime: 45,
                          color1: ColorsConst.mainColor,
                          color2: ColorsConst.mainColor),
                    ],
                  ),
                )),
    );
  }
}
