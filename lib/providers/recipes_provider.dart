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
      OverlayLoadingProgress.stop();
      getRecipes();
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
}
