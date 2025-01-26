import 'package:get/get.dart';
import 'package:grocery_express/model/shop.dart';
import 'package:grocery_express/model/userv2.dart';
import 'package:grocery_express/userPreferences/user_preferences.dart';

class CurrentUser extends GetxController {
  Rx<Users> currentUserInfo = Users(0, '', '', '', '', '', '', '', 8).obs;
  Rx<Shop> currentShopInfo = Shop(0, 1, '', '', '', '', '', '', '').obs;

  Users get user => currentUserInfo.value;
  Shop get shop => currentShopInfo.value;

  void onInit() {
    super.onInit();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    Users? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserInfo();
    if (getUserInfoFromLocalStorage != null) {
      currentUserInfo.value = getUserInfoFromLocalStorage;
    }
  }

  Future<void> clearUserInfo() async {
    await RememberUserPrefs.removeUserInfo(); // Clear SharedPreferences
    currentUserInfo.value =
        Users(0, '', '', '', '', '', '', '', 8); // Reset state
  }
}
