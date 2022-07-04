import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/cubit/states.dart';
import 'package:my_news_app/dio/dio_helper.dart';
import 'package:my_news_app/screens/business_screen.dart';
import 'package:my_news_app/screens/sports_screen.dart';
import 'package:my_news_app/screens/technology_screen.dart';
import 'package:my_news_app/screens/entertainment_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.account_balance_wallet),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_esports),
      label: 'Entertainment',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.devices_other),
      label: 'Technology',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.emoji_events),
      label: 'Sports',
    ),
  ];

  List<String> appBarName = [
    'Business',
    'Entertainment',
    'Technology',
    'Sports'
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const EntertainmentScreen(),
    const TechnologyScreen(),
    const SportsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getEntertainment();
    if (index == 2) getTechnology();
    if (index == 3) getSports();

    emit(NewsBottomNavBarState());
  }

  /// ************************************************************************* */

  //////////////////////////////////////business///////////////////////////////////////////////

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'business',
        'apiKey': 'e2f2941302da483ca44bd6a777550b0a',
      },
    ).then((value) {
      business = value.data['articles'];

      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  ///////////////////////////////////entertainment///////////////////////////////////////////

  List<dynamic> entertainment = [];

  void getEntertainment() {
    emit(NewsGetEntertainmentLoadingState());
    if (entertainment.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'entertainment',
          'apiKey': 'e2f2941302da483ca44bd6a777550b0a',
        },
      ).then((value) {
        entertainment = value.data['articles'];

        emit(NewsGetEntertainmentSuccessState());
      }).catchError((error) {
        emit(NewsGetEntertainmentErrorState(error.toString()));
      });
    } else {
      emit(NewsGetEntertainmentSuccessState());
    }
  }

  //////////////////////////////////technology///////////////////////////////////////////////////

  List<dynamic> technology = [];

  void getTechnology() {
    emit(NewsGetTechnologyLoadingState());
    if (technology.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'technology',
          'apiKey': 'e2f2941302da483ca44bd6a777550b0a',
        },
      ).then((value) {
        technology = value.data['articles'];

        emit(NewsGetTechnologySuccessState());
      }).catchError((error) {
        emit(NewsGetTechnologyErrorState(error.toString()));
      });
    } else {
      emit(NewsGetTechnologySuccessState());
    }
  }

  ///////////////////////////////////////sports///////////////////////////////////////////////////

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'cu',
          'category': 'sports',
          'apiKey': 'e2f2941302da483ca44bd6a777550b0a',
        },
      ).then((value) {
        sports = value.data['articles'];

        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  /////////////////////////////////////search///////////////////////////////////////////////

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': 'e2f2941302da483ca44bd6a777550b0a',
      },
    ).then((value) {
      search = value.data['articles'];

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
