import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/cubit/states.dart';

import '../models/ad.model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Ad> adsList = [];
  int sliderIndex = 0;

  void getAds() async {
    try {
      emit(HomeLoadingState());
      var adsData = await rootBundle.loadString("assets/data/sample.json");
      var decodedData =
          List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);
      adsList = decodedData.map((e) => Ad.fromJson(e)).toList();
      emit(HomeSuccessState());
    } catch (e) {
      emit(HomeErrorState(e.toString()));
      print(e);
    }
  }

  void changeSliderIndex(int index) {
    sliderIndex = index;
    emit(HomeChangeSliderIndexState());
  }
}
