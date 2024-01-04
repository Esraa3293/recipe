// import 'package:shared_preferences/shared_preferences.dart';
//
// abstract class PreferencesService {
//   static SharedPreferences? prefs;
//
//   static bool checkLoggedIn() {
//     bool isLogged = prefs?.getBool("loggedIn") ?? false;
//     return isLogged;
//   }
// }

// import 'package:flutter/material.dart';
//
// import '../utils/colors.dart';
//
// class TestPage extends StatelessWidget {
//   const TestPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var changeColorListener1 = ValueNotifier(false);
//     var changeColorListener2 = ValueNotifier(false);
//     var changeColorListener3 = ValueNotifier(false);
//     var changeColorListener4 = ValueNotifier(false);
//     var changeColorListener5 = ValueNotifier(false);
//
//     return Scaffold(
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ValueListenableBuilder(
//               valueListenable: changeColorListener1,
//               builder: (context, color, child) => InkWell(
//                 onTap: () {
//                   changeColorListener1.value =!changeColorListener1.value;
//                 },
//                 child: Icon(
//                   Icons.star,
//                   size: 15,
//                   color: color ? ColorsConst.grayColor : ColorsConst.mainColor,
//                 ),
//               ),
//             ),
//             ValueListenableBuilder(
//               valueListenable: changeColorListener2,
//               builder: (context, color, child) => InkWell(
//                 onTap: () {
//                   changeColorListener2.value =!changeColorListener2.value;
//                 },
//                 child: Icon(
//                   Icons.star,
//                   size: 15,
//                   color: color ? ColorsConst.grayColor : ColorsConst.mainColor,
//                 ),
//               ),
//             ),
//             ValueListenableBuilder(
//               valueListenable: changeColorListener3,
//               builder: (context, color, child) => InkWell(
//                 onTap: () {
//                   changeColorListener3.value =!changeColorListener3.value;
//                 },
//                 child: Icon(
//                   Icons.star,
//                   size: 15,
//                   color: color ? ColorsConst.grayColor : ColorsConst.mainColor,
//                 ),
//               ),
//             ),
//             ValueListenableBuilder(
//               valueListenable: changeColorListener4,
//               builder: (context, color, child) => InkWell(
//                 onTap: () {
//                   changeColorListener4.value =!changeColorListener4.value;
//                 },
//                 child: Icon(
//                   Icons.star,
//                   size: 15,
//                   color: color ? ColorsConst.grayColor : ColorsConst.mainColor,
//                 ),
//               ),
//             ),
//             ValueListenableBuilder(
//               valueListenable: changeColorListener5,
//               builder: (context, color, child) => InkWell(
//                 onTap: () {
//                   changeColorListener5.value =!changeColorListener5.value;
//                 },
//                 child: Icon(
//                   Icons.star,
//                   size: 15,
//                   color: color ? ColorsConst.grayColor : ColorsConst.mainColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
