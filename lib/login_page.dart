import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
// import 'package:grocery_express/cart_page.dart';
import 'package:grocery_express/home_page.dart';
// import 'package:get/get.dart';
import 'package:grocery_express/model/userv2.dart';
// import 'package:grocery_express/rider_home_page.dart';
import 'package:grocery_express/rider_profile.dart';
// import 'package:grocery_express/seller_home_page.dart';
import 'package:grocery_express/shop/seller_profile.dart';
import 'package:grocery_express/userPreferences/current_user.dart';
import 'package:grocery_express/userPreferences/user_preferences.dart';
import 'api_connection/api_connection.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;

  final CurrentUser currentUserInfo = Get.put(CurrentUser());

  // loginUser() async {
  //   try {
  //     var res = await http.post(
  //       Uri.parse(API.login),
  //       body: {
  //         "email": _emailController.text.trim(),
  //         "password": _passwordController.text.trim(),
  //       },
  //     );

  //     if (res.statusCode == 200) {
  //       var resBodyLogin = jsonDecode(res.body);
  //       if (resBodyLogin['loginSuccessful'] == true) {
  //         Fluttertoast.showToast(msg: "Succesfully Login, Welcome!");

  //         Users userinfo = Users.fromJson(resBodyLogin["userData"]);

  //         //save remeber user/ auto login last user
  //         await RememberUserPrefs.storeUserInfo(userinfo);

  //         // Navigate based on role
  //         if (userinfo.role_id == 1) {
  //           // Navigate to Customer Home Page
  //           Get.to(const HomePage());
  //         } else if (userinfo.role_id == 2) {
  //           // Navigate to Seller Home Page
  //           Get.to(SellerProfilePage());
  //         } else if (userinfo.role_id == 3) {
  //           // Navigate to Cart Page (Rider Page)
  //           Get.to(const CartPage());
  //         } else {
  //           Fluttertoast.showToast(msg: "Invalid User Role");
  //         }
  //       } else {
  //         Fluttertoast.showToast(msg: "Please Write Correct Password & Email.");
  //       }
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

  loginUser() async {
    try {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          "email": _emailController.text.trim(),
          "password": _passwordController.text.trim(),
        },
      );

      if (res.statusCode == 200) {
        var resBodyLogin = jsonDecode(res.body);

        if (resBodyLogin['loginSuccessful'] == true) {
          Fluttertoast.showToast(msg: "Successfully Login, Welcome!");

          Users userinfo = Users.fromJson(resBodyLogin["userData"]);

          // Save user data for auto-login
          await RememberUserPrefs.storeUserInfo(userinfo);

          // Update CurrentUser state
          final currentUserController = Get.find<CurrentUser>();
          currentUserController.currentUserInfo.value = userinfo;

          // Navigate based on role
          if (userinfo.role_id == 1) {
            // Navigate to Customer Home Page
            Get.to(const HomePage());
          } else if (userinfo.role_id == 2) {
            // Navigate to Seller Home Page
            Get.to(SellerProfilePage());
          } else if (userinfo.role_id == 3) {
            // Navigate to Cart Page (Rider Page)
            Get.to(RiderProfile());
          } else {
            Fluttertoast.showToast(msg: "Invalid User Role");
          }
        } else {
          Fluttertoast.showToast(msg: "Incorrect Password or Email.");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Error: Unable to login. Please try again.");
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: "An error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Text(
                'Login to your account.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please sign in to your account',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email field
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isObscured,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Forgot password logic
                        },
                        child: const Text('Forgot password?'),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Sign In button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            loginUser();
                          }
                        },
                        child: const Text('Sign In',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Center(child: Text('Or sign in with')),

              const SizedBox(height: 16),

              // Social buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.android, size: 32, color: Colors.grey),
                    onPressed: () {
                      // Google sign-in logic
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.apple, size: 32, color: Colors.grey),
                    onPressed: () {
                      // Apple sign-in logic
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Register link
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text('Don\'t have an account? Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
