abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {}

class HomeChangeSliderIndexState extends HomeStates {}

class HomeErrorState extends HomeStates {
  String error;

  HomeErrorState(this.error);
}
