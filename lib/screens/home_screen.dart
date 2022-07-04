import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_news_app/components/components.dart';
import 'package:my_news_app/cubit/cubit.dart';
import 'package:my_news_app/cubit/states.dart';
import 'package:my_news_app/screens/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          backgroundColor: HexColor('171717'),
          appBar: AppBar(
            backgroundColor: HexColor('BD1616'),
            title: Text(
              cubit.appBarName[cubit.currentIndex],
              style: GoogleFonts.oswald(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                iconSize: 30,
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: const Icon(Icons.search_outlined),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: buildBottomNavigationBar(),
        );
      },
    );
  }
}
