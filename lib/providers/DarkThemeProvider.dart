import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Brightness _theme = Brightness.light;
  Brightness get Theme => _theme;

  changeTheme() {
    if (_theme == Brightness.light) {
      _theme = Brightness.dark;
    } else {
      _theme = Brightness.light;
    }
    notifyListeners();
  }
}
