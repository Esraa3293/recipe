abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeGetAdsLoadingState extends HomeStates {}

class HomeGetAdsSuccessState extends HomeStates {}

class HomeGetAdsErrorState extends HomeStates {
  String error;

  HomeGetAdsErrorState(this.error);
}

class HomeChangeSliderIndexState extends HomeStates {}
