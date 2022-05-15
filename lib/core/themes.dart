import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/core/lib_color_schemes.g.dart';

CustomTheme customTheme = CustomTheme();

class CustomTheme extends ChangeNotifier {
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
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
      );

  ThemeData get darkTheme => ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: kDarkColorScheme,
        scaffoldBackgroundColor: kDarkColorScheme.background.withOpacity(.6),
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
      );
}
