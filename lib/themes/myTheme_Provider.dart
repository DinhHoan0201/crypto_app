import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

final ThemeData blueTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Colors.blue,
    onPrimary: Colors.white,
  ),
);

final ThemeData yellowTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Colors.yellow,
    onPrimary: Colors.black,
  ),
);

final ThemeData pinkTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Colors.pink,
    onPrimary: Colors.white,
  ),
);

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = FlexThemeData.light(scheme: FlexScheme.mandyRed);
  ThemeData get themeData => _themeData;
  void setTheme(FlexScheme scheme) {
    _themeData = FlexThemeData.light(scheme: scheme);
    notifyListeners();
  }
}
