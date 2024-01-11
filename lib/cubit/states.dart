import '../models/ad.model.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeGetAdsLoadingState extends HomeStates {}

class HomeGetAdsSuccessState extends HomeStates {
  List<Ad> adsList;

  HomeGetAdsSuccessState(this.adsList);
}

class HomeGetAdsErrorState extends HomeStates {
  String error;

  HomeGetAdsErrorState(this.error);
}

class HomeChangeSliderIndexState extends HomeStates {}
