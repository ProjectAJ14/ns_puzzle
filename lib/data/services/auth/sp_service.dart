import 'package:shared_preferences/shared_preferences.dart';

import '../../../ui/utils/constant.dart';

class SPService {
  static late SharedPreferences instance;

  static Future<void> init() async {
    instance = await SharedPreferences.getInstance();
  }

  static Future<bool> isAuthenticated() async {
    return instance.getBool(Constants.isAuthenticated) ?? false;
  }

  static Future<bool> setAuthenticated(bool value) async {
    return await instance.setBool(Constants.isAuthenticated, value);
  }

  static Future<void> clear() async {
    await instance.clear();
  }
}
