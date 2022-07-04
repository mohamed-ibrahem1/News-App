// //*************************************************************************************************************** */
// //   base url: newsapi.org/
// // method (url): v2/top-headlines?
// // queries : country=us&category=technology&apiKey=e2f2941302da483ca44bd6a777550b0a
// //*************************************************************************************************************** */



// Widget customListTile(Article article, BuildContext context) {
//   return InkWell(
//     onTap: () async {
//       if (await canLaunch(article.url!)) {
//         await launch(article.url!);
//       } else {
//         throw 'Could not launch ${article.url}';
//       }
//     },