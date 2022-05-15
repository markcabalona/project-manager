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
      );

  ThemeData get darkTheme => ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: kDarkColorScheme,
        scaffoldBackgroundColor: kDarkColorScheme.background.withOpacity(.6),
        errorColor: kDarkColorScheme.error,
      );
}
