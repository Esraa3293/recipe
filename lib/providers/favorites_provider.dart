import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:recipe/models/favorite.model.dart';
import 'package:recipe/utils/toast_message_status.dart';
import 'package:recipe/widgets/toast_message_widget.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Favorite>? _favorites;

  List<Favorite>? get favorites => _favorites;

  Future<void> getFavorites() async {
    try {
      var result =
          await FirebaseFirestore.instance.collection('favorites').get();
      if (result.docs.isNotEmpty) {
        _favorites =
            result.docs.map((doc) => Favorite.fromJson(doc.data())).toList();
      } else {
        _favorites = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
      _favorites = [];
      notifyListeners();
    }
  }

  Future<void> addUsersToFavorites(String favoriteId, bool isSelected) async {
    try {
      OverlayLoadingProgress.start();
      isSelected
          ? await FirebaseFirestore.instance
              .collection('favorites')
              .doc(favoriteId)
              .update({
              "favoriteUsersIds": FieldValue.arrayUnion(
                  [FirebaseAuth.instance.currentUser?.uid])
            })
          : await FirebaseFirestore.instance
              .collection('favorites')
              .doc(favoriteId)
              .update({
              "favoriteUsersIds": FieldValue.arrayRemove(
                  [FirebaseAuth.instance.currentUser?.uid])
            });
      OverlayLoadingProgress.stop();
      getFavorites();
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
