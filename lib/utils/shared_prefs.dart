import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences prefs;
  SharedPrefs._();
  static final _instance = SharedPrefs._();
  factory SharedPrefs.instance() => _instance;
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void setToken(String token) => prefs.setString('token', token);
  String? get token => prefs.getString('token');
  void setName(String name) => prefs.setString('name', name);
  String get name => prefs.getString('name') ?? '';

  void setUserId(String userId) => prefs.setString('userId', userId);
  String get userId => prefs.getString('userId') ?? '';

  void removeToken(String token) => prefs.remove(token);
  void setEmail(String email) => prefs.setString('email', email);
  String? get email => prefs.getString('email');

  Future<bool> clear() async {
    await prefs.clear();
    prefs = await SharedPreferences.getInstance();
    return true;
  }
}
