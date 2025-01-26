import 'dart:convert';
import 'package:grocery_express/model/userv2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs {
  //save remeber user info
  static Future<void> storeUserInfo(Users userinfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userinfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }

  //get-read User-info
  static Future<Users?> readUserInfo() async {
    Users? currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("currentUser");

    if (userInfo != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userInfo);
      currentUserInfo = Users.fromJson(userDataMap);
    }
    return currentUserInfo;
  }

  static Future<void> removeUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser");
  }
}
