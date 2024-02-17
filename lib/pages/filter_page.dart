import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recipe/pages/filtered_list_page.dart';
import 'package:recipe/providers/recipes_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/navigation.dart';
import 'package:recipe/utils/text_styles.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.filter),
        titleTextStyle: hellix20w800(),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                Provider.of<RecipesProvider>(context, listen: false)
                    .onResetPressed();
              },
              child: Text(
                AppLocalizations.of(context)!.reset,
                style: hellix14w500(),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).r,
        child: Consumer<RecipesProvider>(
          builder: (context, recipeProvider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(AppLocalizations.of(context)!.meal, style: hellix14w700()),
              SizedBox(
                height: 13.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChoiceChip(
                    onSelected: (value) =>
                        recipeProvider.onBFChipSelected(value),
                    label: const Text("BreakFast"),
                    selected: true,
                    selectedColor:
                        recipeProvider.userSelectedValue["mealType"] ==
                                "Breakfast"
                            ? ColorsConst.chipColor
                            : ColorsConst.chipUnselectedColor,
                    labelStyle: hellix12w500().copyWith(
                        color: recipeProvider.userSelectedValue["mealType"] ==
                                "Breakfast"
                            ? ColorsConst.primaryColor
                            : ColorsConst.labelColor),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.w,
                          color: recipeProvider.userSelectedValue["mealType"] ==
                                  "Breakfast"
                              ? ColorsConst.primaryColor
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  ChoiceChip(
                    onSelected: (value) =>
                        recipeProvider.onLChipSelected(value),
                    label: const Text("Lunch"),
                    selected: true,
                    selectedColor:
                        recipeProvider.userSelectedValue["mealType"] == "Lunch"
                            ? ColorsConst.chipColor
                            : ColorsConst.chipUnselectedColor,
                    labelStyle: hellix12w500().copyWith(
                        color: recipeProvider.userSelectedValue["mealType"] ==
                                "Lunch"
                            ? ColorsConst.primaryColor
                            : ColorsConst.labelColor),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.w,
                          color: recipeProvider.userSelectedValue["mealType"] ==
                                  "Lunch"
                              ? ColorsConst.primaryColor
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  ChoiceChip(
                    onSelected: (value) {
                      recipeProvider.onDChipSelected(value);
                    },
                    label: const Text("Dinner"),
                    selected: true,
                    selectedColor:
                        recipeProvider.userSelectedValue["mealType"] == "Dinner"
                            ? ColorsConst.chipColor
                            : ColorsConst.chipUnselectedColor,
                    labelStyle: hellix12w500().copyWith(
                        color: recipeProvider.userSelectedValue["mealType"] ==
                                "Dinner"
                            ? ColorsConst.primaryColor
                            : ColorsConst.labelColor),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1.w,
                          color: recipeProvider.userSelectedValue["mealType"] ==
                                  "Dinner"
                              ? ColorsConst.primaryColor
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(AppLocalizations.of(context)!.serving,
                  style: hellix14w700()),
              const SizedBox(
                height: 13,
              ),
              Slider(
                value: recipeProvider.servingSliderValue.toDouble(),
                onChanged: (value) {
                  recipeProvider.onServingChanged(value);
                  print(recipeProvider.userSelectedValue["serving"]);
                },
                min: 0,
                max: 10,
                divisions: 9,
                label: recipeProvider.servingSliderValue.round().toString(),
                activeColor: ColorsConst.primaryColor,
                inactiveColor: ColorsConst.grayColor,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(AppLocalizations.of(context)!.prepTime,
                  style: hellix14w700()),
              SizedBox(
                height: 13.h,
              ),
              Slider(
                value: recipeProvider.timeSliderValue.toDouble(),
                onChanged: (value) {
                  recipeProvider.onTimeSliderChanged(value);
                },
                min: 0,
                max: 750,
                divisions: 200,
                label: recipeProvider.timeSliderValue.toString(),
                activeColor: ColorsConst.primaryColor,
                inactiveColor: ColorsConst.grayColor,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(AppLocalizations.of(context)!.calories,
                  style: hellix14w700()),
              SizedBox(
                height: 13.h,
              ),
              Slider(
                value: recipeProvider.caloriesSliderValue.toDouble(),
                onChanged: (value) {
                  recipeProvider.onCaloriesSliderChanged(value);
                },
                min: 0,
                max: 700,
                divisions: 300,
                label: recipeProvider.caloriesSliderValue.toString(),
                activeColor: ColorsConst.primaryColor,
                inactiveColor: ColorsConst.grayColor,
              ),
              SizedBox(
                height: 40.h,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await Provider.of<RecipesProvider>(context, listen: false)
                        .getFilteredList();
                    if (context.mounted) {
                      Navigation.push(
                          context: context, page: const FilteredListPage());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(20.w, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      )),
                  child: Text(
                    AppLocalizations.of(context)!.apply,
                    style:
                        hellix16white().copyWith(fontWeight: FontWeight.w600),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
