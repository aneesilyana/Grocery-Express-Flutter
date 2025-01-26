// import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_express/userPreferences/current_user.dart';
// import 'package:grocery_express/api_connection/api_connection.dart';
// import 'package:grocery_express/model/user.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'user_provider.dart';

class PersonalProfilePage extends StatefulWidget {
  const PersonalProfilePage({Key? key}) : super(key: key);

  @override
  State<PersonalProfilePage> createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {
  // final _usernameController = TextEditingController();
  // final _fnameController = TextEditingController();
  // final _emailController = TextEditingController();
  // final _phoneController = TextEditingController();
  // // final _passwordController = TextEditingController();
  // final _addressController = TextEditingController();
  File? _profilePicture;

  @override
  void initState() {
    super.initState();
    // // Load user data from UserProvider
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // // _usernController.text = userProvider.username ?? '';
    // _fnameController.text = userProvider.fullName ?? '';
    // _emailController.text = userProvider.email ?? '';
    // _phoneController.text = userProvider.phoneNumber ?? '';
    // _addressController.text = userProvider.address ?? '';
    // // _passworController.text = userProvider.password ?? '';
    // _profilePicture = userProvider.profilePicture;
  }

  final CurrentUser currentUserInfo = Get.put(CurrentUser());
  bool _isObscured = true;

  Widget userItems(IconData iconData, String userData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(iconData, size: 30, color: Colors.black),
          const SizedBox(width: 16),
          Text(
            userData,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  // Future<bool> updateUser(User user) async {

  //   try {
  //     var res = await http.post(Uri.parse(API.updateProfile))
  //       body: {
  //         'id': user.id.toString(),
  //         'username': user.username,
  //         'fname': user.fname ?? '',
  //         'email': user.email,
  //         'phonenum': user.phonenum ?? '',
  //         'password': user.password, // If updating password
  //         'address': user.address ?? '',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final responseBody = jsonDecode(response.body);
  //       return responseBody['updateSuccessful'];
  //     } else {
  //       print("Server error: ${response.statusCode}");
  //       return false;
  //     }
  //   } catch (e) {
  //     print("Error updating user: $e");
  //     return false;
  //   }
  // }

  // Function to pick an image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profilePicture = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Profile'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.black), // Customize the icon and color
          onPressed: () {
            // Define what happens when the button is pressed
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profilePicture != null
                        ? FileImage(_profilePicture!)
                        : const AssetImage('assets/images/default_profile.png')
                            as ImageProvider,
                    child: _profilePicture == null
                        ? const Icon(Icons.camera_alt,
                            size: 30, color: Colors.white)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Full Name Field
              const Text("Full Name",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              userItems(Icons.person, currentUserInfo.user.fname),
              const SizedBox(height: 16),

              // Email Field
              const Text("Email",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              userItems(Icons.email, currentUserInfo.user.email),
              const SizedBox(height: 16),

              // Phone Field
              const Text("Phone",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              userItems(Icons.phone, currentUserInfo.user.phonenum),
              const SizedBox(height: 16),

              // Address Field
              const Text("Address",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              userItems(Icons.home, currentUserInfo.user.address),
              const SizedBox(height: 16),

              // Address Field
              const Text("Password",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              // TextFormField(
              //   controller: _passwordController,
              //   obscureText: _isObscured,
              //   decoration: InputDecoration(
              //     labelText: 'Password',
              //     border: const OutlineInputBorder(),
              //     suffixIcon: IconButton(
              //       icon: Icon(
              //         _isObscured ? Icons.visibility : Icons.visibility_off,
              //       ),
              //       onPressed: () {
              //         setState(() {
              //           _isObscured = !_isObscured;
              //         });
              //       },
              //     ),
              //   ),
              // ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.password, size: 30, color: Colors.black),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        _isObscured
                            ? '*' *
                                currentUserInfo
                                    .user.password.length // Mask the password
                            : currentUserInfo
                                .user.password, // Show plain password
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                        overflow: TextOverflow
                            .ellipsis, // Prevent long password overflow
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // // Update the user's profile in UserProvider
                    // Provider.of<UserProvider>(context, listen: false)
                    //     .updateUser(
                    //   fullName: _fnameController.text.trim(),
                    //   email: _emailController.text.trim(),
                    //   phoneNumber: _phoneController.text.trim(),
                    //   address: _addressController.text.trim(),
                    //   profilePicture: _profilePicture,
                    // );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Profile Updated Successfully")),
                    );
                    Navigator.pop(
                        context); // Navigate back to the previous page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
