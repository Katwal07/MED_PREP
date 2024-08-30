
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/tools.dart';
import 'colors.dart';

class BitpointXTheme {
  static ThemeData buildDarkTheme() {
    return ThemeData(
      fontFamily: 'Entypo',
      brightness: Brightness.dark,
      cardColor: Colors.white,
      highlightColor: Colors.amber.withOpacity(0.5),
      splashColor: Colors.amber.withOpacity(0.4),
      buttonTheme: const ButtonThemeData(
          //colorScheme: kColorScheme,
          textTheme: ButtonTextTheme.normal,
          buttonColor: kDarkBG),
      primaryColorLight: kLightBG,
      focusColor: Colors.white,
      primaryColor: kLightPrimary,
      scaffoldBackgroundColor: kLightBG,
      canvasColor: bkBackgroundColor,
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: bkTextColor,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
        displaySmall: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: MyColors().secondDarkColor(1)),
        displayLarge: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
            color: MyColors().mainDarkColor(1)),
        headlineMedium: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: MyColors().secondColor(1)),
        titleMedium: TextStyle(
          color: bkTextColor,
        ),
        bodyMedium:
            TextStyle(fontSize: 14.0, color: MyColors().secondDarkColor(1)),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        iconTheme: IconThemeData(
          color: kLightAccent,
        ),
        toolbarTextStyle: TextTheme(
            titleLarge: TextStyle(
              color: bkTextColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
            ),
            titleMedium: TextStyle(
              color: bkTextColor,
            )).bodyMedium,
        titleTextStyle: TextTheme(
            titleLarge: TextStyle(
              color: bkTextColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
            ),
            titleMedium: TextStyle(
              color: bkTextColor,
            )).titleLarge,
      ),
      //colorScheme: kColorScheme.copyWith(secondary: Color(0xffe84545)),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: kLightAccent,
        selectionColor: kTeal100,
      ), //colorScheme: ColorScheme(brightness: '', primary: null, onPrimary: null, secondary: null, onSecondary: null, error: null, onError: null, surface: null, onSurface: null).copyWith(error: kErrorRed),
    );
  }

  static ThemeData buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: MedUI.backgroundColor,
      textTheme: GoogleFonts.poppinsTextTheme(),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: MedUI.primaryBrandColor),
    );
  }
}

class MyColors {
//  Color _mainColor = Color(0xFFFF4E6A);
  // Color _mainColor = Color(0xFFea5c44);
  Color _mainColor = Color(0xFF6F35A5);
  // Color _mainDarkColor = Color(0xFFea5c44);
  Color _mainDarkColor = Color(0xFFFFFFFF);
  Color _secondColor = Color(0xFFFFFFFF);
  Color _secondDarkColor = Color(0xFFeeeeee);
  Color _accentColor = Color(0xFF8C98A8);
  Color _accentDarkColor = Color(0xFF9999aa);
  Color _scaffoldDarkColor = Color(0xFF2C2C2C);
  Color _scaffoldColor = Color(0xFFFAFAFA);

  Color mainColor(double opacity) {
    return this._mainColor.withOpacity(opacity);
  }

  Color secondColor(double opacity) {
    return this._secondColor.withOpacity(opacity);
  }

  Color accentColor(double opacity) {
    return this._accentColor.withOpacity(opacity);
  }

  Color mainDarkColor(double opacity) {
    return this._mainDarkColor.withOpacity(opacity);
  }

  Color secondDarkColor(double opacity) {
    return this._secondDarkColor.withOpacity(opacity);
  }

  Color accentDarkColor(double opacity) {
    return this._accentDarkColor.withOpacity(opacity);
  }

  Color scaffoldColor(double opacity) {
    // test if brightness is dark or not
    return _scaffoldColor.withOpacity(opacity);
  }

  Color scaffoldDarkColor(double opacity) {
    // test if brightness is dark or not
    return _scaffoldDarkColor.withOpacity(opacity);
  }
}
