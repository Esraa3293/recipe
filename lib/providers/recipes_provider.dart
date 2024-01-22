import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:recipe/models/recipe.model.dart';
import 'package:recipe/utils/toast_message_status.dart';
import 'package:recipe/widgets/toast_message_widget.dart';

class RecipesProvider extends ChangeNotifier {
  List<Recipe>? _recipes;

  List<Recipe>? get recipes => _recipes;

  Future<void> getRecipes() async {
    try {
      var result = await FirebaseFirestore.instance.collection('recipes').get();
      if (result.docs.isNotEmpty) {
        _recipes =
            result.docs.map((doc) => Recipe.fromJson(doc.data())).toList();
      } else {
        _recipes = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
      _recipes = [];
      notifyListeners();
    }
  }
}
