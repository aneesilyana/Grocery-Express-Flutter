import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_express/login_page.dart';
import 'package:grocery_express/userPreferences/current_user.dart';
import 'package:grocery_express/userPreferences/user_preferences.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart'; // For completed orders
// import 'user_provider.dart'; // For user profile details
// import 'main.dart'; // For navigation routes
import 'personal_profile_page.dart'; // Navigate to PersonalProfilePage

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final CurrentUser currentUserInfo = Get.put(CurrentUser());

  signOut() async {
    var resultResponse = await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey,
        title: const Text(
          "Sign Out",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you sure?\nYou want to logout from app?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "No",
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: "loggedOut");
            },
            child: const Text(
              "Yes",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );

    if (resultResponse == "loggedOut") {
      // Clear local storage and reset app state
      await RememberUserPrefs.removeUserInfo();

      // Reset CurrentUser state
      final currentUserController = Get.find<CurrentUser>();
      currentUserController.clearUserInfo();

      // Navigate to login page
      Get.off(const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final completedOrders = Provider.of<CartProvider>(context).completedOrders;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Profile Settings",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header Section
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to PersonalProfilePage on avatar tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalProfilePage(),
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/default_profile.png"),
                  ),
                ),
                const SizedBox(width: 16),
                // Expanded(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         currentUserInfo.user.username,
                //         style: const TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       const SizedBox(height: 4),
                //       Text(
                //         currentUserInfo.user.email,
                //         style: const TextStyle(
                //           fontSize: 16,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: Obx(() {
                    final user = currentUserInfo.user;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (user.username.isEmpty) ? "Guest" : user.username,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.email.isEmpty ? "No email" : user.email,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // My Orders Section
            const Text(
              "My Orders",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            completedOrders.isEmpty
                ? const Text(
                    "No completed orders yet.",
                    style: TextStyle(color: Colors.grey),
                  )
                : Column(
                    children: completedOrders.map<Widget>((order) {
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order ID: ${order['orderId']}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Total: RM ${order['totalPrice'].toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ...order['items'].map<Widget>((item) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${item['name']} (${item['quantity']} pcs)",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "RM ${item['price'].toStringAsFixed(2)}",
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 16),

            // Profile Settings Menu
            const Text(
              "Profile",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildSettingsOption(
              context,
              icon: Icons.person,
              title: "Personal Data",
              onTap: () {
                // Navigate to Personal Profile Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PersonalProfilePage(),
                  ),
                );
              },
            ),
            _buildSettingsOption(
              context,
              icon: Icons.settings,
              title: "Settings",
              onTap: () {
                // Handle Settings Navigation
              },
            ),
            _buildSettingsOption(
              context,
              icon: Icons.credit_card,
              title: "Extra Card",
              onTap: () {
                // Handle Extra Card Navigation
              },
            ),
            const SizedBox(height: 16),

            // Sign Out Button
            ElevatedButton(
              onPressed: () {
                // // Handle Sign Out (Navigate to Login Page)
                // Navigator.pushReplacementNamed(context, Routes.login);

                signOut();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                "Sign Out",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 28, color: Colors.orange),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
