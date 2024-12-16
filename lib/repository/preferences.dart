import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future<void> saveLastVisitedPage(String routeName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastVisitedPage', routeName);
  }

  Future<String?> getLastVisitedPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('lastVisitedPage')??'home.dart';
  }

  Future<String> loadSavedDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('birthday_day') ?? '';
  }
  Future<String> loadSavedMonth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('birthday_month') ?? '';
  }
  Future<String> loadSavedYear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('birthday_year') ?? '';
  }

  Future<void> saveBirthday(String day,String month, String year) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('birthday_day', day);
    await prefs.setString('birthday_month', month);
    await prefs.setString('birthday_year', year);
  }

  Future<String> loadSavedName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nickname') ?? '';
  }

  Future<void> saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', name);
  }

  Future<String> loadSavedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('image') ?? '';
  }

  Future<void> saveImage(String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('image', image);
  }

}