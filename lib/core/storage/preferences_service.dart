import 'package:shared_preferences/shared_preferences.dart';

/// Non-sensitive preferences (e.g. remembered email). Never store tokens here.
class PreferencesService {
  PreferencesService(this._prefs);

  final SharedPreferences _prefs;

  static const _rememberedEmailKey = 'remembered_email';
  static const _rememberMeKey = 'remember_me';

  Future<void> setRememberedEmail(String? email) async {
    if (email == null || email.isEmpty) {
      await _prefs.remove(_rememberedEmailKey);
      return;
    }
    await _prefs.setString(_rememberedEmailKey, email);
  }

  String? getRememberedEmail() => _prefs.getString(_rememberedEmailKey);

  Future<void> setRememberMe(bool value) =>
      _prefs.setBool(_rememberMeKey, value);

  bool getRememberMe() => _prefs.getBool(_rememberMeKey) ?? false;
}
