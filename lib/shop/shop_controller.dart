import 'package:get/get.dart';
import 'package:grocery_express/api_connection/api_connection.dart';
import 'package:grocery_express/model/shop.dart';
import 'package:grocery_express/userPreferences/current_user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ShopController extends GetxController {
  Rx<Shop> currentShopInfo = Shop(0, 1, '', '', '', '', '', '', '').obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> fetchShopById(int shopId) async {
    isLoading.value = true;
    errorMessage.value = '';

    final CurrentUser currentUserInfo = Get.put(CurrentUser());

    try {
      final response = await http.get(Uri.parse(
          '${API.fetchShop}/?shop_id=${currentUserInfo.user.user_id}'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          currentShopInfo.value = Shop.fromJson(data['shop'][0]);
        } else {
          errorMessage.value = data['message'];
        }
      } else {
        errorMessage.value =
            "Failed to fetch shop data. Status code: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
