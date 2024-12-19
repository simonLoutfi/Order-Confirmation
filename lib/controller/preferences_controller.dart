import 'package:proto/repository/preferences.dart';

class PreferencesController {
  Future<void> saveLastVisitedPage(String routeName) async {
    await Preferences().saveLastVisitedPage(routeName);  
  }

  Future<String?> getLastVisitedPage() async {
    return await Preferences().getLastVisitedPage();
  }

  Future<String> loadSavedDay() async {
    return await Preferences().loadSavedDay();
  }
  Future<String> loadSavedMonth() async {
    return await Preferences().loadSavedMonth();
  }
  Future<String> loadSavedYear() async {
    return await Preferences().loadSavedYear();
  }

  Future<void> saveBirthday(String day,String month, String year) async {
    await Preferences().saveBirthday(day, month, year);
  }

  Future<String> loadSavedName() async {
    return await Preferences().loadSavedName();
  }

  Future<void> saveName(String name) async {
    await Preferences().saveName(name);
  }

  Future<String> loadSavedGender() async {
    return await Preferences().loadSavedName();
  }

  Future<void> saveGender(String gender) async {
    await Preferences().saveName(gender);
  }

  Future<String> loadSavedImage() async {
    return await Preferences().loadSavedImage();
  }

  Future<void> saveImage(String image) async {
    await Preferences().saveImage(image);
  }


}