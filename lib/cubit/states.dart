abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavBarState extends NewsStates {}

//////////////////////////////Business/////////////////////////////////////

class NewsGetBusinessLoadingState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

//////////////////////////////Entertainment/////////////////////////////////////

class NewsGetEntertainmentLoadingState extends NewsStates {}

class NewsGetEntertainmentSuccessState extends NewsStates {}

class NewsGetEntertainmentErrorState extends NewsStates {
  final String error;

  NewsGetEntertainmentErrorState(this.error);
}

//////////////////////////////Technology/////////////////////////////////////


class NewsGetTechnologyLoadingState extends NewsStates {}

class NewsGetTechnologySuccessState extends NewsStates {}

class NewsGetTechnologyErrorState extends NewsStates {
  final String error;

  NewsGetTechnologyErrorState(this.error);
}

//////////////////////////////Sports/////////////////////////////////////


class NewsGetSportsLoadingState extends NewsStates {}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  final String error;

  NewsGetSportsErrorState(this.error);
}

//////////////////////////////Search/////////////////////////////////////


class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  final String error;

  NewsGetSearchErrorState(this.error);
}
