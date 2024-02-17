import 'package:flutter/material.dart';
import 'package:recipe/utils/colors.dart';
import 'package:recipe/utils/text_styles.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: hellix20w800(),
      ),
      fontFamily: 'Hellix',
      colorScheme: ColorScheme.fromSeed(
          seedColor: ColorsConst.primaryColor,
          primary: ColorsConst.primaryColor),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: hellix14w400().copyWith(color: ColorsConst.grayColor),
        prefixIconColor: ColorsConst.grayColor,
        suffixIconColor: ColorsConst.grayColor,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorsConst.borderColor)),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorsConst.borderColor)),
      ));
}
