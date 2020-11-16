import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _prefs;
  static initialize() async {
    if (_prefs != null) {
      return _prefs;
    } else {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  static Future<void> mailKaydet(String mail) async {
    return _prefs.setString('mail', mail);
  }

  static Future<void> sifreKaydet(String sifre) async {
    return _prefs.setString('sifre', sifre);
  }

  static Future<void> depoSil() async {
    return _prefs.clear();
  }

  static Future<void> giris() async {
    return _prefs.setBool('giris', true);
  }

  static String get getMail => _prefs.getString('mail') ?? null;
  static String get getSifre => _prefs.getString('sifre') ?? null;
  static String get getGiris => _prefs.getString('giris') ?? null;
}
