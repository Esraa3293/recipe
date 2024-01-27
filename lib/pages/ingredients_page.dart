import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe/providers/ingredients_provider.dart';

import '../utils/colors.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  void init() async {
    await Provider.of<IngredientsProvider>(context, listen: false)
        .getIngredients();
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
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "In My Kitchen",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: Consumer<IngredientsProvider>(
        builder: (context, ingredientsProvider, child) =>
            ingredientsProvider.ingredients == null
                ? const Center(child: CircularProgressIndicator())
                : (ingredientsProvider.ingredients?.isEmpty ?? false)
                    ? const Center(
                        child: Text(
                          "No Data Found!",
                          style: TextStyle(
                              color: ColorsConst.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                              leading: Checkbox(
                                activeColor: ColorsConst.primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                value: ingredientsProvider
                                    .ingredients![index].users_ids
                                    ?.contains(
                                        FirebaseAuth.instance.currentUser?.uid),
                                onChanged: (bool? value) {
                                  ingredientsProvider.addIngredientToUser(
                                      ingredientsProvider
                                              .ingredients![index].docId ??
                                          "",
                                      value ?? false);
                                },
                              ),
                              title: Text(
                                ingredientsProvider.ingredients![index].name ??
                                    "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                        itemCount: ingredientsProvider.ingredients!.length),
      ),
    );
  }
}
