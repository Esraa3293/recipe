import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:recipe/utils/images.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int sliderIndex = 0;
  CarouselController carouselController = CarouselController();

  List<String> meals = [
    ImagesPath.meal1,
    ImagesPath.meal2,
    ImagesPath.meal3,
    ImagesPath.meal4,
    ImagesPath.meal5
  ];

  @override
  Widget build(BuildContext context) {
    // String? email = PreferencesService.prefs?.getString("email") ?? "";
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: const Color(0xFF868365),
          //   title: Text("Welcome $email"),
          //   actions: [
          //     IconButton(
          //       onPressed: () {
          //         Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          //         PreferencesService.prefs?.remove("loggedIn");
          //       },
          //       icon: const Icon(Icons.logout),
          //     )
          //   ],
          // ),
          body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
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
                  items: meals.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration:
                                const BoxDecoration(color: Colors.amber),
                            child: Image.asset(
                              meals[sliderIndex],
                              scale: .8,
                            ));
                      },
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        sliderIndex--;
                        if (sliderIndex == -1) {
                          sliderIndex = meals.length - 1;
                          // sliderIndex = meals.indexOf(meals.last);
                        }
                        setState(() {});
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    IconButton(
                      onPressed: () {
                        sliderIndex++;
                        if (sliderIndex == meals.length) {
                          sliderIndex = 0;
                          // sliderIndex = meals.indexOf(meals.first);
                        }
                        setState(() {});
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ],
            ),
          ),
          DotsIndicator(
            dotsCount: meals.length,
            position: sliderIndex,
            onTap: (position) async {
              await carouselController.animateToPage(position);
              sliderIndex = position;
              setState(() {});
            },
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          )
        ],
      )),
    );
  }
}
