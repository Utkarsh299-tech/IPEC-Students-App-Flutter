import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static final LocalData _singleton = LocalData._internal();

  factory LocalData() {
    return _singleton;
  }

  LocalData._internal();

  final kUsername = 'username';
  final kPassword = 'password';
  final kName = 'name';
  final kImage = 'userImage';
  final kLoginStatus = 'userImage';
  final kCookie = 'cookie';
  Future<void> saveUserPreference(
      String username, String password, String name, String userImage,
      {bool loginStatus = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseDatabase.instance
        .reference()
        .child('app_data')
        .child(username)
        .child(DateTime.now().year.toString())
        .set({
      kUsername: username,
      kPassword: password,
      kName: name,
      kImage: userImage,
      'last_seen_year': DateTime.now().year.toString(),
      'last_seen_month': DateTime.now().month.toString(),
      'last_seen_day': DateTime.now().day.toString(),
    });

    prefs.setString(kUsername, username);
    prefs.setString(kPassword, password);
    prefs.setString(kName, name);
    prefs.setString(kImage, userImage);
    prefs.setBool(kLoginStatus, loginStatus);
  }

  Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(kUsername);
  }

  Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(kPassword);
  }

  Future<String> getImagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(kImage);
  }

  Future<String> getNamePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(kName);
  }

  Future<void> setLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(kLoginStatus, false);
  }

  Future<void> saveCookie(String cookie) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kCookie, cookie);
  }

  Future<String> getCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(kCookie);
  }

  Future<bool> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(kLoginStatus);
  }
}
