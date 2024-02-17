import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:recipe/providers/recipes_provider.dart';
import 'package:recipe/widgets/animated_staggered_list_widget.dart';
import 'package:recipe/widgets/recommended_widget.dart';

class FilteredListPage extends StatefulWidget {
  const FilteredListPage({super.key});

  @override
  State<FilteredListPage> createState() => _FilteredListPageState();
}

class _FilteredListPageState extends State<FilteredListPage> {
  void init() async {
    await Provider.of<RecipesProvider>(context, listen: false)
        .getFilteredList();
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
        title: Text(AppLocalizations.of(context)!.filteredList),
      ),
      body: Consumer<RecipesProvider>(
        builder: (context, value, child) =>
            AnimationLimiter(
              child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 10).r,
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (context, index) =>
                      AnimatedStaggeredList(
                          widget:
                          RecommendedWidget(
                              recipe: value.filteredRecipes![index]),
                          index: index),
                  separatorBuilder: (context, index) =>
                  const Divider(
                    color: Colors.transparent,
                  ),
                  itemCount: value.filteredRecipes!.length),
            ),
      ),
    );
  }
}
