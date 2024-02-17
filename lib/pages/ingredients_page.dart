import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:recipe/models/ingredient.model.dart';
import 'package:recipe/pages/filter_page.dart';
import 'package:recipe/pages/side_menu_page.dart';
import 'package:recipe/providers/ingredients_provider.dart';
import 'package:recipe/utils/navigation.dart';
import 'package:recipe/utils/numbers.dart';
import 'package:recipe/utils/text_styles.dart';
import 'package:recipe/widgets/animated_staggered_list_widget.dart';

import '../utils/colors.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  List<Ingredient> searchList = [];
  late ZoomDrawerController controller;
  late TextEditingController searchController;

  void init() async {
    await Provider.of<IngredientsProvider>(context, listen: false)
        .getIngredients();
  }

  void searchIngredients(String searchedIngredient) {
    searchList = Provider.of<IngredientsProvider>(context, listen: false)
        .ingredients!
        .where((ingredient) =>
            ingredient.name!.toLowerCase().startsWith(searchedIngredient))
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
        appBar: AppBar(
          centerTitle: true,
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
          title: Text(
            AppLocalizations.of(context)!.ingredients,
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
                            hintText:
                                AppLocalizations.of(context)!.searchIngredients,
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
                        onChanged: (searchedIngredient) {
                          searchIngredients(searchedIngredient);
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
              height: 20.h,
            ),
            Consumer<IngredientsProvider>(
              builder: (context, ingredientsProvider, child) =>
                  ingredientsProvider.ingredients == null
                      ? const Center(child: CircularProgressIndicator())
                      : (ingredientsProvider.ingredients?.isEmpty ?? false)
                          ? Center(
                              child: Text(
                                "No Ingredients Found!",
                                style: hellixw700(),
                              ),
                            )
                          : Expanded(
                              child: AnimationLimiter(
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  itemBuilder:
                                      (context, index) =>
                                          AnimationConfiguration.staggeredList(
                                              position: index,
                                              delay: const Duration(
                                                  milliseconds: 100),
                                              child: SlideAnimation(
                                                duration: const Duration(
                                                    milliseconds: 2500),
                                                curve: Curves
                                                    .fastLinearToSlowEaseIn,
                                                verticalOffset: -250.h,
                                                child: ScaleAnimation(
                                                  duration: const Duration(
                                                      milliseconds: 1500),
                                                  curve: Curves
                                                      .fastLinearToSlowEaseIn,
                                                  child: AnimatedStaggeredList(
                                                      widget:
                                                          searchController
                                                                  .text.isEmpty
                                                              ? Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  height: 100.h,
                                                                  margin: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              20)
                                                                      .r,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(15
                                                                              .r),
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(ingredientsProvider.ingredients?[index].imageUrl ??
                                                                              ""),
                                                                          fit: BoxFit
                                                                              .cover)),
                                                                  child:
                                                                      ListTile(
                                                                    leading:
                                                                        Checkbox(
                                                                      activeColor:
                                                                          ColorsConst
                                                                              .primaryColor,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.r)),
                                                                      value: ingredientsProvider
                                                                          .ingredients![
                                                                              index]
                                                                          .users_ids
                                                                          ?.contains(FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              ?.uid),
                                                                      onChanged:
                                                                          (bool?
                                                                              value) {
                                                                        ingredientsProvider.addIngredientToUser(
                                                                            ingredientsProvider.ingredients![index].docId ??
                                                                                "",
                                                                            value ??
                                                                                false);
                                                                      },
                                                                    ),
                                                                    title: Text(
                                                                      ingredientsProvider
                                                                              .ingredients![index]
                                                                              .name ??
                                                                          "",
                                                                      style:
                                                                          hellix20w700(),
                                                                    ),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  height: 100.h,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  margin: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              20)
                                                                      .r,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(15
                                                                              .r),
                                                                      image: DecorationImage(
                                                                          image: NetworkImage(searchList[index].imageUrl ??
                                                                              ""),
                                                                          fit: BoxFit
                                                                              .cover)),
                                                                  child:
                                                                      ListTile(
                                                                    leading:
                                                                        Checkbox(
                                                                      activeColor:
                                                                          ColorsConst
                                                                              .primaryColor,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.r)),
                                                                      value: searchList[
                                                                              index]
                                                                          .users_ids
                                                                          ?.contains(FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              ?.uid),
                                                                      onChanged:
                                                                          (bool?
                                                                              value) {
                                                                        ingredientsProvider.addIngredientToUser(
                                                                            searchList[index].docId ??
                                                                                "",
                                                                            value ??
                                                                                false);
                                                                      },
                                                                    ),
                                                                    title: Text(
                                                                      searchList[index]
                                                                              .name ??
                                                                          "",
                                                                      style:
                                                                          hellix20w700(),
                                                                    ),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20.r)),
                                                                  ),
                                                                ),
                                                      index: index),
                                                ),
                                              )),
                                  itemCount: searchController.text.isEmpty
                                      ? ingredientsProvider.ingredients!.length
                                      : searchList.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    color: Colors.transparent,
                                  ),
                                  padding: const EdgeInsets.only(bottom: 10).r,
                                ),
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
