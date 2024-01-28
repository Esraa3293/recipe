import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/providers/recipes_provider.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/numbers.dart';
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<RecipesProvider>(
            builder: (context, recipesProvider, child) =>
                recipesProvider.recipes == null
                    ? const Center(child: CircularProgressIndicator())
                    : (recipesProvider.recipes?.isEmpty ?? false)
                        ? const Center(
                            child: Text(
                            'No Data Found!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: ColorsConst.primaryColor),
                          ))
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Numbers.appHorizontalPadding),
                            child: FlexibleGridView(
                              axisCount: GridLayoutEnum.twoElementsInRow,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              children: recipesProvider.recipes!
                                  .map((recipe) => RecipeWidget(recipe: recipe))
                                  .toList(),
                            ),
                          )),
      ),
    );
  }
}
