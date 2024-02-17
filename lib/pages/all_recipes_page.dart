import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:recipe/providers/recipes_provider.dart';
import 'package:recipe/utils/numbers.dart';
import 'package:recipe/utils/text_styles.dart';
import 'package:recipe/widgets/recipe_widget.dart';

class AllRecipesPage extends StatefulWidget {
  const AllRecipesPage({super.key});

  @override
  State<AllRecipesPage> createState() => _AllRecipesPageState();
}

class _AllRecipesPageState extends State<AllRecipesPage> {
  void init() async {
    await Provider.of<RecipesProvider>(context, listen: false).getRecipes();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.allRecipes,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Consumer<RecipesProvider>(
            builder: (context, recipesProvider, child) => recipesProvider
                        .recipes ==
                    null
                ? const Center(child: CircularProgressIndicator())
                : (recipesProvider.recipes?.isEmpty ?? false)
                    ? Center(
                        child: Text(
                        'No Data Found!',
                        style: hellixw700().copyWith(fontSize: 16.sp),
                      ))
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Numbers.appHorizontalPadding),
                        child: AnimationLimiter(
                          child: AnimationLimiter(
                            child: FlexibleGridView(
                              axisCount: GridLayoutEnum.twoElementsInRow,
                              crossAxisSpacing: 20.w,
                              mainAxisSpacing: 20.h,
                              children: recipesProvider.recipes!
                                  .map((recipe) => RecipeWidget(recipe: recipe))
                                  .toList(),
                            ),
                          ),
                        ))),
      ),
    );
  }
}
