import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:recipe/models/ingredient.model.dart';
import 'package:recipe/utils/toast_message_status.dart';
import 'package:recipe/widgets/toast_message_widget.dart';

class IngredientsProvider extends ChangeNotifier {
  List<Ingredient>? _ingredients;

  List<Ingredient>? get ingredients => _ingredients;

  Future<void> getIngredients() async {
    try {
      var result =
          await FirebaseFirestore.instance.collection('ingredients').get();
      if (result.docs.isNotEmpty) {
        _ingredients = result.docs
            .map((doc) => Ingredient.fromJson(doc.data(), doc.id))
            .toList();
      } else {
        _ingredients = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
      _ingredients = [];
      notifyListeners();
    }
  }

  Future<void> addIngredientToUser(String ingredientId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      isAdd
          ? await FirebaseFirestore.instance
              .collection('ingredients')
              .doc(ingredientId)
              .update({
              "users_ids": FieldValue.arrayUnion(
                  [FirebaseAuth.instance.currentUser?.uid])
            })
          : await FirebaseFirestore.instance
              .collection('ingredients')
              .doc(ingredientId)
              .update({
              "users_ids": FieldValue.arrayRemove(
                  [FirebaseAuth.instance.currentUser?.uid])
            });
      OverlayLoadingProgress.stop();
      getIngredients();
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
