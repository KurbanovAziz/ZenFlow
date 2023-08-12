// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Fonts/AppFonts.dart';
import 'AppTheme.dart';

class AppColors {
  static Color PRIMARY_COLOR = const Color(0xff269DD7);
  static Color PRIMARY_COLOR_OPACITY = const Color(0xff082F54);
  static Color LIGHT_GREEN = const Color(0xff62B0A3);
  static Color LIGHT_GREY_COLOR = const Color(0xFFEFEFF7);
  static Color BLACK = const Color(0xff000000);
  static Color GRAY = const Color(0xff959595);
  static Color TRANSPARENT_COLOR = Colors.transparent;
  static Color RED_COLOR = const Color(0xFFDC2E45);
  static Color WHITE_COLOR = const Color(0xffFFFFFF);
  static Color YELLOW_COLOR = const Color(0xffFFEC41);
  static Color Black_Shade = const Color(0xff181818);
  static Color Green = const Color(0xff085430);
  static Color Mint_Green = Color(0xFF2AD97A);
}

class GetTheme extends GetxController {
  var isDark = true.obs;

  updateMode() {
    isDark.value = true;
    ThemeHelper().switchTheme();
    isDark.value = false;
    update();
  }
}

class ThemeHelper {
  final _box = GetStorage();

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool _loadThemeFromBox() => _box.read('') ?? false;

  _saveThemeToBox(bool isDarkMode) => _box.write('', isDarkMode);

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);

    _saveThemeToBox(!_loadThemeFromBox());
  }
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: whitePrimary,
    primaryColor: whitePrimary,
    primarySwatch: Colors.teal,
    brightness: Brightness.light,
    cardColor: whiteOnPrimary,
    textTheme: TTextTheme.lightTextTheme,
    appBarTheme: const AppBarTheme(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: darkPrimary,
    primaryColor: darkPrimary,
    primarySwatch: Colors.teal,
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    appBarTheme: const AppBarTheme(),
    cardColor: const Color(0xff2f3e46),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(),
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
  );
}

class TTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    headline1: TextStyle(
        color: blackOnPrimary,
        fontSize: 24,
        fontFamily: Weights.londrinaRegular),
    headline2: TextStyle(
        color: blackOnPrimary,
        fontSize: 22,
        fontFamily: Weights.londrinaRegular),
    headline3: TextStyle(
        color: blackOnPrimary,
        fontSize: 20,
        fontFamily: Weights.londrinaRegular),
    headline4: TextStyle(
        color: blackOnPrimary, fontSize: 18, fontFamily: Weights.londrinaLight),
    headline5: TextStyle(
        color: blackOnPrimary, fontSize: 16, fontFamily: Weights.londrinaLight),
    headline6: TextStyle(
        color: blackOnPrimary, fontSize: 10, fontFamily: Weights.londrinaLight),

    //subtitle2: GoogleFonts.poppins(color: Colors.deepPurple, fontSize: 24),
  );
  static TextTheme darkTextTheme = TextTheme(
    headline1: TextStyle(
        color: whiteOnPrimary,
        fontSize: 24,
        fontFamily: Weights.londrinaRegular),
    headline2: TextStyle(
        color: whiteOnPrimary,
        fontSize: 22,
        fontFamily: Weights.londrinaRegular),
    headline3: TextStyle(
        color: whiteOnPrimary,
        fontSize: 20,
        fontFamily: Weights.londrinaRegular),
    headline4: TextStyle(
        color: whiteOnPrimary, fontSize: 18, fontFamily: Weights.londrinaLight),
    headline5: TextStyle(
        color: whiteOnPrimary, fontSize: 16, fontFamily: Weights.londrinaLight),
    headline6: TextStyle(
        color: whiteOnPrimary, fontSize: 10, fontFamily: Weights.londrinaLight),
  );
}
