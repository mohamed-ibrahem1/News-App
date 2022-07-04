import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:my_news_app/cubit/cubit.dart';
import 'package:my_news_app/cubit/states.dart';
import 'package:url_launcher/url_launcher.dart';

///////////////////////////////////////////
///دة اللينك بتاع السيرش في الابلكيشن بتاعي
//  https://newsapi.org/v2/everything?q=tesla&apiKey=e2f2941302da483ca44bd6a777550b0a

///////////////////////////////navigateTo///////////////////////////////////////////////////////////////
///دي عشان تنقل بين اسكرين و التانية

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////buildArticleItem////////////////////////////////////////////////////////

Widget buildArticleItem(article, context) {
  DateTime time = DateFormat('yyyy-MM-dd').parse(article['publishedAt']);

  return InkWell(
    onTap: () async {
      if (await canLaunch(article['url'])) {
        await launch(article['url']);
      } else {
        throw 'Could not launch ${article['url']}';
      }
    },
    child: Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: HexColor('171717'),
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildCondition(
            condition:
                '${article['source']['name']}' != 'WXII12 Winston-Salem' &&
                        article['urlToImage'] != null &&
                        '${article['urlToImage']}'.contains('https://') &&
                        '${article['urlToImage']}'.contains('.jpg') ||
                    '${article['source']['name']}' != 'WXII12 Winston-Salem' &&
                        article['urlToImage'] != null &&
                        '${article['urlToImage']}'.contains('https://') &&
                        '${article['urlToImage']}'.contains('.png') ||
                    '${article['source']['name']}' != 'WXII12 Winston-Salem' &&
                        article['urlToImage'] != null &&
                        '${article['urlToImage']}'.contains('https://') &&
                        '${article['urlToImage']}'.contains('.jpeg'),
            builder: (context) => Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    '${article['urlToImage']}',
                  ),
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            fallback: (context) => Center(
              child: Icon(
                Icons.image_not_supported,
                size: 80,
                color: HexColor('F05454'),
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: HexColor('BD1616'),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              '${article['source']['name']}',
              textAlign: TextAlign.justify,
              style: GoogleFonts.anton(
                color: HexColor('DDDDDD'),
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            '${article['title']}',
            style: GoogleFonts.varela(
              color: HexColor('DDDDDD'),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            // خلي بالك من الحتة دي عشان دي اللي بتنظملك التاريخ و بتشيل الاصفار اللي بتظهر بعد التاريخ
            //السطر دة معناة ان لو طول الاسترينج اكبر من 10 هيسيب الكلام اللي من 0 ل 10 و يمسح الباقي
            /////////////////////////////////////////////////////////////////////////////////////////////////////
            '$time'.length > 10 ? '$time'.substring(0, 10) : '$time',
            style: GoogleFonts.varela(
              color: HexColor('DDDDDD'),
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

/////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////buildBottomNavBar////////////////////////////////////////////

Widget buildBottomNavigationBar() {
  return BlocConsumer<NewsCubit, NewsStates>(
    listener: (BuildContext context, Object? state) {},
    builder: (BuildContext context, state) {
      var cubit = NewsCubit.get(context);
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            backgroundColor: HexColor('30475E'),
            //السطرين اللي تحت دول عشان تشيل الكلام اللي تحت الايقونة بتاعت ال
            //BottomNavigationBar

            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: HexColor('BD1616'),
            unselectedItemColor: HexColor('DDDDDD'),
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItem,
          ),
        ),
      );
    },
  );
}

////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////articleBuilder//////////////////////////////////////

Widget articleBuilder(list) => BuildCondition(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => const SizedBox(
          height: 5,
        ),
        itemCount: list.length,
      ),
      fallback: (context) => Center(
          child: CircularProgressIndicator(
        color: HexColor('BD1616'),
      )),
    );
