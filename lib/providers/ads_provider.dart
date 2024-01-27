import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:recipe/models/ad.model.dart';
import 'package:recipe/utils/toast_message_status.dart';

import '../widgets/toast_message_widget.dart';

class AdsProvider extends ChangeNotifier {
  CarouselController? carouselController;
  int sliderIndex = 0;
  List<Ad>? _adsList;

  List<Ad>? get adsList => _adsList;

  void initCarousel() {
    carouselController = CarouselController();
    notifyListeners();
  }

  void disposeCarousel() {
    carouselController = null;
    notifyListeners();
  }

  void onPageChanged(int index) {
    sliderIndex = index;
    notifyListeners();
  }

  void onDotTapped(int position) async {
    await carouselController?.animateToPage(position);
    sliderIndex = position;
    notifyListeners();
  }

  void onArrowBackTapped() async {
    await carouselController?.previousPage();
    notifyListeners();
  }

  void onArrowForwardTapped() async {
    await carouselController?.nextPage();
    notifyListeners();
  }

  Future<void> getAds() async {
    try {
      var result = await FirebaseFirestore.instance.collection('ads').get();
      if (result.docs.isNotEmpty) {
        _adsList = result.docs.map((doc) => Ad.fromJson(doc.data())).toList();
      } else {
        _adsList = [];
      }
      notifyListeners();
    } catch (e) {
      OverlayToastMessage.show(
        widget: ToastMessage(
          message: e.toString(),
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
      _adsList = [];
      notifyListeners();
    }
  }
}
