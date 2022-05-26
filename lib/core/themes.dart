import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lib_color_schemes.g.dart';
import 'shared_prefs.dart';

CustomTheme customTheme = CustomTheme();

class CustomTheme extends ChangeNotifier {
  Future<void> initTheme() async {
    final prefs = SharedPrefs.prefs;
    _isDarkTheme = prefs.getBool('isDark') ?? false;
    notifyListeners();
  }

  void _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', _isDarkTheme);
  }

  static bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _saveTheme();
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: kLightColorScheme,
        scaffoldBackgroundColor: kLightColorScheme.background,
        errorColor: kLightColorScheme.error,
        splashColor: kLightColorScheme.secondary,
        appBarTheme: AppBarTheme(
          foregroundColor: kLightColorScheme.onPrimary,
          backgroundColor: kLightColorScheme.primary,
        ),
        listTileTheme: ListTileThemeData(
          tileColor: kLightColorScheme.secondaryContainer,
          iconColor: kLightColorScheme.onSecondaryContainer,
          textColor: kLightColorScheme.onSecondaryContainer,
          style: ListTileStyle.list,
        ),
        textTheme: TextTheme(
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: kLightColorScheme.onBackground,
          ),
          button: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );

  ThemeData get darkTheme => ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: kDarkColorScheme,
        scaffoldBackgroundColor: kDarkColorScheme.background,
        errorColor: kDarkColorScheme.error,
        splashColor: kDarkColorScheme.secondary,
        appBarTheme: AppBarTheme(
          foregroundColor: kDarkColorScheme.onPrimary,
          backgroundColor: kDarkColorScheme.primary,
        ),
        listTileTheme: ListTileThemeData(
          tileColor: kDarkColorScheme.secondaryContainer,
          iconColor: kDarkColorScheme.onSecondaryContainer,
          textColor: kDarkColorScheme.onSecondaryContainer,
          style: ListTileStyle.list,
        ),
        textTheme: TextTheme(
          headline5: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: kDarkColorScheme.onBackground,
          ),
          button: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );
}
