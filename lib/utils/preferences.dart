import 'dart:convert';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class Preferences {
  final SharedPreferences shared;
  Preferences(this.shared);
  List<String> get whitePackages =>
      shared.getStringList("white_packages") ?? [];

  Locale? get locale => shared.getString("lang_code") == null
      ? null
      : Locale(shared.getString("lang_code") ?? "en",
          shared.getString("country_code"));

  Future saveLocale(Locale locale) async {
    shared.setString("lang_code", locale.languageCode);
    if (locale.countryCode != null)
      shared.setString("country_code", locale.countryCode!);
  }

  UserModel? getAuth() {
    if (shared.getString("auth") != null) {
      var str = shared.getString("auth");
      UserModel user = UserModel.fromJson(jsonDecode(str!));
      // print(user.token);
      return user;
    }
    return null;
  }

  Future saveCridentials(UserModel user) async {
    shared.setString("auth", jsonEncode(user.toJson()));
  }

  Future deleteCridentials() async {
    // shared.setString("auth", jsonEncode(user.toJson()));
    shared.remove('auth');
  }

  static Future<Preferences> init() =>
      SharedPreferences.getInstance().then((value) => Preferences(value));
}
