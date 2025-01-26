import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_express/api_connection/api_connection.dart';
import 'package:grocery_express/model/userv2.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phonenumController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  // final TextEditingController _createdAtController = TextEditingController();

  bool _isObscured = true;
  bool _termsAccepted = false;

  // Role selection
  String? _selectedRole;

  Future<bool> validateEmail() async {
    final email = _emailController.text;
    try {
      final response = await http.post(
        Uri.parse(API.validateEmail),
        body: {'email': email},
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return responseBody['isEmailValid'] ?? true;
      } else {
        return false;
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      print("Error validating email: $e");
      return false;
    }
  }

  registerUser() async {
    if (_selectedRole == null) {
      Fluttertoast.showToast(msg: "Please select a role.");
      return;
    }

    Users userModel = Users(
      1, // Placeholder for user_id
      _usernameController.text.trim(),
      _fnameController.text.trim(),
      _emailController.text.trim(),
      _phonenumController.text.trim(),
      _passwordController.text.trim(),
      _addressController.text.trim(),
      "", // created_at is managed by the backend
      int.parse(_selectedRole!), // Ensure _selectedRole is an int
    );

    try {
      var res = await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(), // Correctly converts all fields to strings
      );

      if (res.statusCode == 200) {
        var resBodySignUp = jsonDecode(res.body);
        if (resBodySignUp['signUpSuccessful'] == true) {
          Fluttertoast.showToast(
              msg: "Congratulations, you have signed up successfully.");

          setState(() {
            _usernameController.clear();
            _passwordController.clear();
            _emailController.clear();
            _fnameController.clear();
            _phonenumController.clear();
            _addressController.clear();
            _selectedRole = null;
          });
        } else {
          Fluttertoast.showToast(msg: "Error Occurred, Please Try Again.");
        }
      } else {
        Fluttertoast.showToast(msg: "Server error: ${res.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(msg: "An error occurred: $e");
    }
  }

  // registerUser() async {
  //   Users userModel = Users(
  //     1,
  //     _usernameController.text.trim(),
  //     _fnameController.text.trim(),
  //     _emailController.text.trim(),
  //     _phonenumController.text.trim(),
  //     _passwordController.text.trim(),
  //     _addressController.text.trim(),
  //     _createdAtController.text.trim(),
  //     int.parse(_selectedRole!),
  //   );

  //   try {
  //     var res = await http.post(
  //       Uri.parse(API.signUp),
  //       body: userModel.toJson(),
  //     );

  //     if (res.statusCode == 200) {
  //       var resBodySignUp = jsonDecode(res.body);
  //       if (resBodySignUp['signUpSuccessful'] == true) {
  //         Fluttertoast.showToast(
  //             msg: "Congratulation, you are sign up successfully.");

  //         setState(() {
  //           _usernameController.clear();
  //           _passwordController.clear();
  //           _emailController.clear();
  //           _fnameController.clear();
  //           _phonenumController.clear();
  //           _addressController.clear();
  //           _selectedRole = null;
  //         });
  //       } else {
  //         Fluttertoast.showToast(msg: "Error Occured, Please Try Again.");
  //       }
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

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
                'Create your new account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Create an account to start using the app',
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
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Username field
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'User Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Full Name field
                    TextFormField(
                      controller: _fnameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Phone Number field
                    TextFormField(
                      controller: _phonenumController,
                      decoration: const InputDecoration(
                        labelText: 'Contact Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your contact number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Full Name field
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
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
                    const SizedBox(height: 16),

                    // Role selection
                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      decoration: const InputDecoration(
                        labelText: 'Select Role',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: '1',
                          child: Text('Customer'),
                        ),
                        DropdownMenuItem(
                          value: '2',
                          child: Text('Seller'),
                        ),
                        DropdownMenuItem(
                          value: '3',
                          child: Text('Rider'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a role';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Terms and conditions checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _termsAccepted,
                          onChanged: (bool? value) {
                            setState(() {
                              _termsAccepted = value ?? false;
                            });
                          },
                        ),
                        const Text('I agree with'),
                        TextButton(
                          onPressed: () {
                            // Show Terms of Service and Privacy Policy
                          },
                          child: const Text(
                            'Terms of Service and Privacy Policy',
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Register button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: _termsAccepted
                            ? () async {
                                if (_formKey.currentState!.validate()) {
                                  // Wait for validateEmail to complete
                                  bool isEmailValid = await validateEmail();

                                  if (isEmailValid) {
                                    // Proceed to register user if email is valid
                                    await registerUser();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Please use a different email address.");
                                  }
                                }
                              }
                            : null,
                        child: const Text('Register',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
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

              // Sign In link
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Already have an account? Sign In'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
