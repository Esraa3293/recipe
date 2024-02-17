import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:recipe/models/recipe.model.dart';
import 'package:recipe/pages/filter_page.dart';
import 'package:recipe/pages/side_menu_page.dart';
import 'package:recipe/providers/recipes_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/navigation.dart';
import 'package:recipe/utils/numbers.dart';
import 'package:recipe/utils/text_styles.dart';
import 'package:recipe/widgets/animated_staggered_list_widget.dart';
import 'package:recipe/widgets/recommended_widget.dart';

class RecentlyViewedPage extends StatefulWidget {
  const RecentlyViewedPage({super.key});

  @override
  State<RecentlyViewedPage> createState() => _RecentlyViewedPageState();
}

class _RecentlyViewedPageState extends State<RecentlyViewedPage> {
  late ZoomDrawerController controller;
  late TextEditingController searchController;
  List<Recipe> searchedList = [];

  void init() async {
    await Provider.of<RecipesProvider>(context, listen: false)
        .getRecentlyViewedRecipes();
  }

  void searchRecentlyViewed(String searchedRecipe) {
    searchedList = Provider.of<RecipesProvider>(context, listen: false)
        .recentlyViewedRecipes!
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
          title: Text(AppLocalizations.of(context)!.recentlyViewed),
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
                          searchRecentlyViewed(searchedRecipe);
                        },
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
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('recipes')
                  .where("recentlyViewedUsersIds",
                      arrayContains: FirebaseAuth.instance.currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshots) {
                List<Recipe> recipes = snapshots.data?.docs
                        .map((e) => Recipe.fromJson(e.data(), e.id))
                        .toList() ??
                    [];
                if (snapshots.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshots.hasError) {
                  return const Center(child: Text("Something went wrong!"));
                } else if (snapshots.hasData) {
                  if (snapshots.data?.docs.isNotEmpty ?? false) {
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
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                    right: 8.0)
                                                .r,
                                            child: Slidable(
                                                endActionPane: ActionPane(
                                                    motion:
                                                        const StretchMotion(),
                                                    extentRatio: .2,
                                                    children: [
                                                      SlidableAction(
                                                        onPressed:
                                                            (context) async {
                                                          await Provider.of<
                                                                      RecipesProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .removeRecentlyViewedRecipeToUser(
                                                                  recipes[index]
                                                                          .docId ??
                                                                      "");
                                                        },
                                                        label:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .delete,
                                                        icon: Icons
                                                            .delete_forever_outlined,
                                                        backgroundColor:
                                                            ColorsConst
                                                                .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.r),
                                                      )
                                                    ]),
                                                child: RecommendedWidget(
                                                    recipe: recipes[index])),
                                          )
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
                      "No Recently Viewed Recipes",
                      style: hellix16w500()
                          .copyWith(color: ColorsConst.primaryColor),
                    ));
                  }
                } else {
                  return const Center(
                      child: Text("No Recently Viewed Recipes"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
