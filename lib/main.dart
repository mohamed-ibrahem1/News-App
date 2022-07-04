import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_news_app/dio/dio_helper.dart';
import 'package:my_news_app/screens/home_screen.dart';

import 'cubit/bloc_observer.dart';
import 'cubit/cubit.dart';

/////////////////////////////////////////////////////////////////////////////////////////
///https://newsapi.org/v2/top-headlines?country=cu&category=sports&apiKey=e2f2941302da483ca44bd6a777550b0a
///دة الايميل بتاع الاخبار بتاعت الكورة لاسبانيا
////////////////////////////////////////////////////////////////////////////////////////////////

void main() {
  BlocOverrides.runZoned(
    () {},
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()..getBusiness(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: HexColor('BD1616'),
              statusBarIconBrightness: Brightness.light,
            ),
          ),
        ),
        home:  const HomeScreen(),
      ),
    );
  }
}
