import 'package:flutter/material.dart';
import 'package:flutter_chat_app/theme/dark_clolor.dart';
import 'package:flutter_chat_app/theme/styles.dart';
import 'package:google_fonts/google_fonts.dart';
export 'extentions.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    backgroundColor: DarkColor.secondary,
    secondaryHeaderColor: DarkColor.darkGrey,
    primaryColor: DarkColor.primary,
    textTheme: GoogleFonts.muliTextTheme(
      TextTheme(
        body1: TextStyle(color: Colors.white),
        body2: TextStyle(color: DarkColor.extraExtraLightGrey),
        title: TextStyle(color: Colors.white),
        subtitle: TextStyle(color: DarkColor.extraExtraLightGrey),
      ),
    ),
    dividerColor: DarkColor.lightGrey,
    bottomAppBarColor:  DarkColor.darkGrey,
    iconTheme: IconThemeData(color: DarkColor.lightGrey),
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        title:  TextStyles.title,
      ),
      color:DarkColor.darkGrey,
      iconTheme: IconThemeData(color: DarkColor.lightGrey)
    ),
  );
}
