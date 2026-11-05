import 'package:flutter/material.dart';

//Trang thai cua giao dien hien thi (sang / toi)
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  //Chuyen doi giao dien sang sang / toi
  void toggle(Brightness currentBrightness) {
    _themeMode = currentBrightness == Brightness.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    notifyListeners();
  }
}
