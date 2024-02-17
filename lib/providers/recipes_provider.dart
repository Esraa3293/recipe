import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:recipe/models/recipe.model.dart';
import 'package:recipe/utils/toast_message_status.dart';
import 'package:recipe/widgets/toast_message_widget.dart';

class RecipesProvider extends ChangeNotifier {
  List<Recipe>? _recipes;

  List<Recipe>? get recipes => _recipes;

  List<Recipe>? _freshRecipes;

  List<Recipe>? get freshRecipes => _freshRecipes;

  List<Recipe>? _recommendedRecipes;

  List<Recipe>? get recommendedRecipes => _recommendedRecipes;

  List<Recipe>? _favoriteRecipes;

  List<Recipe>? get favoriteRecipes => _favoriteRecipes;

  List<Recipe>? _recentlyViewedRecipes;

  List<Recipe>? get recentlyViewedRecipes => _recentlyViewedRecipes;

  List<Recipe>? _filteredRecipes;

  List<Recipe>? get filteredRecipes => _filteredRecipes;

  var userSelectedValue = {};
  int servingSliderValue = 1;
  int timeSliderValue = 25;
  int caloriesSliderValue = 35;

  onBFChipSelected(bool value) {
    userSelectedValue["mealType"] = "Breakfast";
    notifyListeners();
  }

  onLChipSelected(bool value) {
    userSelectedValue["mealType"] = "Lunch";
    notifyListeners();
  }

  onDChipSelected(bool value) {
    userSelectedValue["mealType"] = "Dinner";
    notifyListeners();
  }

  onServingChanged(double value) {
    servingSliderValue = value.toInt();
    userSelectedValue["serving"] = servingSliderValue;
    notifyListeners();
  }

  onTimeSliderChanged(double value) {
    timeSliderValue = value.toInt();
    userSelectedValue["prepTime"] = timeSliderValue;
    notifyListeners();
  }

  onCaloriesSliderChanged(double value) {
    caloriesSliderValue = value.toInt();
    userSelectedValue["calories"] = caloriesSliderValue;
    notifyListeners();
  }

  onResetPressed() {
    userSelectedValue = {};
    servingSliderValue = 0;
    timeSliderValue = 0;
    caloriesSliderValue = 0;
    notifyListeners();
  }

  Future<void> getFilteredList() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where("mealType", isEqualTo: userSelectedValue['mealType'])
          .where("serving", isEqualTo: userSelectedValue['serving'])
          .where("prepTime", isEqualTo: userSelectedValue['prepTime'])
          .where("calories", isEqualTo: userSelectedValue['calories'])
          .get();
      if (result.docs.isNotEmpty) {
        _filteredRecipes = result.docs
            .map((doc) => Recipe.fromJson(doc.data(), doc.id))
            .toList();
      } else {
        _filteredRecipes = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
      _filteredRecipes = [];
      notifyListeners();
    }
  }

  Future<void> getRecipes() async {
    try {
      var result = await FirebaseFirestore.instance.collection('recipes').get();
      if (result.docs.isNotEmpty) {
        _recipes = result.docs
            .map((doc) => Recipe.fromJson(doc.data(), doc.id))
            .toList();
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

  Future<void> getFreshRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('isFresh', isEqualTo: true)
          .limit(5)
          .get();
      if (result.docs.isNotEmpty) {
        _freshRecipes = result.docs
            .map((doc) => Recipe.fromJson(doc.data(), doc.id))
            .toList();
      } else {
        _freshRecipes = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
      _freshRecipes = [];
      notifyListeners();
    }
  }

  Future<void> getRecommendedRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where('isFresh', isEqualTo: false)
          .limit(5)
          .get();
      if (result.docs.isNotEmpty) {
        _recommendedRecipes = result.docs
            .map((doc) => Recipe.fromJson(doc.data(), doc.id))
            .toList();
      } else {
        _recommendedRecipes = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
      _recommendedRecipes = [];
      notifyListeners();
    }
  }

  Future<void> getRecentlyViewedRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where("recentlyViewedUsersIds",
              arrayContains: FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (result.docs.isNotEmpty) {
        _recentlyViewedRecipes = result.docs
            .map((doc) => Recipe.fromJson(doc.data(), doc.id))
            .toList();
      } else {
        _recentlyViewedRecipes = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
      _recentlyViewedRecipes = [];
      notifyListeners();
    }
  }

  Future<void> addRecentlyViewedRecipeToUser(String recipeId) async {
    try {
      await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .update({
        "recentlyViewedUsersIds":
        FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
      });
    } catch (e) {
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
    }
  }

  Future<void> removeRecentlyViewedRecipeToUser(String recipeId) async {
    try {
      await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .update({
        "recentlyViewedUsersIds":
        FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
      });
    } catch (e) {
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
    }
  }

  Future<void> getFavoriteRecipes() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .where("favoriteUsersIds",
              arrayContains: FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (result.docs.isNotEmpty) {
        _favoriteRecipes = result.docs
            .map((doc) => Recipe.fromJson(doc.data(), doc.id))
            .toList();
        print(_favoriteRecipes);
      } else {
        _favoriteRecipes = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
      _favoriteRecipes = [];
      notifyListeners();
    }
  }

  Future<void> addFavoriteToUser(String recipeId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      isAdd
          ? await FirebaseFirestore.instance
              .collection('recipes')
              .doc(recipeId)
              .update({
              "favoriteUsersIds": FieldValue.arrayUnion(
                  [FirebaseAuth.instance.currentUser?.uid])
            })
          : await FirebaseFirestore.instance
              .collection('recipes')
              .doc(recipeId)
              .update({
              "favoriteUsersIds": FieldValue.arrayRemove(
                  [FirebaseAuth.instance.currentUser?.uid])
            });
      await updateRecipe(recipeId);
      OverlayLoadingProgress.stop();
      getFavoriteRecipes();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
    }
  }

  Future<void> updateRecipe(String recipeId) async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId)
          .get();
      Recipe? updatedRecipe;
      if (result.data() != null) {
        updatedRecipe = Recipe.fromJson(result.data()!, result.id);
      } else {
        return;
      }
      var recipeIndex =
          recipes?.indexWhere((recipe) => recipe.docId == recipeId);

      if (recipeIndex != -1) {
        recipes?.removeAt(recipeIndex!);
        recipes?.insert(recipeIndex!, updatedRecipe);
      }

      var freshRecipeIndex =
          freshRecipes?.indexWhere((recipe) => recipe.docId == recipeId);

      if (freshRecipeIndex != -1) {
        freshRecipes?.removeAt(freshRecipeIndex!);
        freshRecipes?.insert(freshRecipeIndex!, updatedRecipe);
      }

      var recommendedRecipeIndex =
          recommendedRecipes?.indexWhere((recipe) => recipe.docId == recipeId);

      if (recommendedRecipeIndex != -1) {
        recommendedRecipes?.removeAt(recommendedRecipeIndex!);
        recommendedRecipes?.insert(recommendedRecipeIndex!, updatedRecipe);
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
      notifyListeners();
    }
  }
}
