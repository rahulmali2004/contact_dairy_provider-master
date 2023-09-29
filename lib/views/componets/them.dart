import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTheme extends ChangeNotifier {
  bool isDark = false;
  final String _myTheme = 'is_dark';

  SharedPreferences prefs;

  MyTheme({required this.prefs});

  bool get getTheme {
    if (prefs.getBool(_myTheme) ?? false) {
      isDark = prefs.getBool(_myTheme)!;
    } else {
      prefs.setBool(_myTheme, isDark);
    }
    return isDark;
  }

  void changeTheme() {
    isDark = !isDark;
    prefs.setBool(_myTheme, isDark);
    notifyListeners();
  }
}
