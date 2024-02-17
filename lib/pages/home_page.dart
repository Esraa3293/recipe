import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:recipe/pages/filter_page.dart';
import 'package:recipe/pages/side_menu_page.dart';
import 'package:recipe/providers/recipes_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/navigation.dart';
import 'package:recipe/utils/numbers.dart';
import 'package:recipe/utils/text_styles.dart';
import 'package:recipe/widgets/ads_widget.dart';
import 'package:recipe/widgets/recipe_widget.dart';
import 'package:recipe/widgets/recommended_widget.dart';
import 'package:recipe/widgets/section_header_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ZoomDrawerController controller;

  void init() async {
    await Provider.of<RecipesProvider>(context, listen: false)
        .getFreshRecipes();
    if (context.mounted) {
      await Provider.of<RecipesProvider>(context, listen: false)
          .getRecommendedRecipes();
    }
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
      mainScreen: SafeArea(
        child: Scaffold(
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
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Numbers.appHorizontalPadding),
                  child: Text("${AppLocalizations.of(context)!.bonjour}, $name",
                      style: hellix12w500()),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Numbers.appHorizontalPadding),
                  child: Text(AppLocalizations.of(context)!.query,
                      style: arbilFatface20()),
                ),
                SizedBox(
                  height: 10.h,
                ),
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
                            // enabled: false,
                            decoration: InputDecoration(
                                prefixIcon: InkWell(
                                  onTap: () {
                                    Navigation.push(
                                        context: context,
                                        page: const FilterPage());
                                  },
                                  child: const Icon(
                                    Icons.search,
                                    color: ColorsConst.grayColor,
                                  ),
                                ),
                                label: InkWell(
                                    onTap: () {
                                      Navigation.push(
                                          context: context,
                                          page: const FilterPage());
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.search)),
                                labelStyle: hellix12w400(),
                                filled: true,
                                fillColor: ColorsConst.containerBgColor,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.r)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.r))),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      InkWell(
                        onTap: () {
                          Navigation.push(
                              context: context, page: const FilterPage());
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
                const AdsWidget(),
                SizedBox(
                  height: 15.h,
                ),
                SectionHeader(sectionName: AppLocalizations.of(context)!.fresh),
                SizedBox(
                  height: 18.h,
                ),
                SizedBox(
                  height: 230.h,
                  child: Consumer<RecipesProvider>(
                    builder: (context, recipesProvider, child) =>
                        recipesProvider.freshRecipes == null
                            ? const Center(child: CircularProgressIndicator())
                            : (recipesProvider.recipes?.isEmpty ?? false)
                                ? Center(
                                    child: Text(
                                      "No Fresh Recipes!",
                                      style: hellixw700()
                                          .copyWith(fontSize: 16.sp),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(
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
                SizedBox(
                  height: 25.h,
                ),
                SectionHeader(
                    sectionName: AppLocalizations.of(context)!.recommended),
                SizedBox(
                  height: 10.h,
                ),
                Consumer<RecipesProvider>(
                  builder: (context, recipesProvider, child) => recipesProvider
                              .freshRecipes ==
                          null
                      ? const Center(child: CircularProgressIndicator())
                      : (recipesProvider.recipes?.isEmpty ?? false)
                          ? Center(
                              child: Text(
                                "No Recommended Recipes!",
                                style: hellixw700().copyWith(fontSize: 16.sp),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(bottom: 10).r,
                              itemBuilder: (context, index) =>
                                  RecommendedWidget(
                                      recipe: recipesProvider
                                          .recommendedRecipes![index]),
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    color: Colors.transparent,
                                  ),
                              itemCount:
                                  recipesProvider.recommendedRecipes?.length ??
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
