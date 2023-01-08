import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static String isLogin = 'Is_Login';

  SharedPrefsHelper._init();

  static final sharedPrefsHelper = SharedPrefsHelper._init();

  factory SharedPrefsHelper() => sharedPrefsHelper;

  SharedPreferences? sharedPreferences;
  void getInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  getBoolPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getBool(isLogin);
    return sharedPreferences;
  }

  void setBoolToPrefs(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(isLogin, value);
  }

  void removesValues() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(isLogin);
  }
}
