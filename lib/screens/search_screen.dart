import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_news_app/components/components.dart';
import 'package:my_news_app/cubit/cubit.dart';
import 'package:my_news_app/cubit/states.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          backgroundColor: HexColor('171717'),
          appBar: AppBar(
            title: Text(
              'Search',
              style: GoogleFonts.oswald(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: HexColor('BD1616'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  style: TextStyle(
                    color: HexColor('DDDDDD'),
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide:
                          BorderSide(color: HexColor('DDDDDD'), width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide:
                          BorderSide(color: HexColor('BD1616'), width: 2.0),
                    ),
                    label: Text(
                      'Search',
                      style: TextStyle(
                        color: HexColor('DDDDDD'),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: HexColor('DDDDDD'),
                    ),
                  ),
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(
                child: articleBuilder(list),
              ),
            ],
          ),
        );
      },
    );
  }
}
