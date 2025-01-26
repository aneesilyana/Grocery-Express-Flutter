import 'dart:convert';
// import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_express/model/shop.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:provider/provider.dart';
// import 'product_provider.dart';
// import 'product.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_express/api_connection/api_connection.dart';
import 'package:grocery_express/seller_home_page.dart';
import 'package:grocery_express/userPreferences/current_user.dart';
import 'package:http/http.dart' as http;

class RegisterShopPage extends StatefulWidget {
  const RegisterShopPage({Key? key}) : super(key: key);

  @override
  _RegisterShopPageState createState() => _RegisterShopPageState();
}

class _RegisterShopPageState extends State<RegisterShopPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  // final _createdAtController = TextEditingController();
  // final _updatedAtController = TextEditingController();
  final _locationController = TextEditingController();
  final _contactController = TextEditingController();

  final CurrentUser currentUserInfo = Get.put(CurrentUser());

  // Role selection
  String? _selectedStatus;

  // File? _image;

  Future<bool> validateShopName() async {
    final shop_name = _nameController.text;
    try {
      final response = await http.post(
        Uri.parse(API.validateShopName),
        body: {'shop_name': shop_name},
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return responseBody['isNameValid'] ?? true;
      } else {
        return false;
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      print("Error validating shop name: $e");
      return false;
    }
  }

  registerShop() async {
    Shop regShopModel = Shop(
      1,
      currentUserInfo.user.user_id,
      _nameController.text.trim(),
      _descController.text.trim(),
      "",
      "",
      _selectedStatus!,
      _contactController.text.trim(),
      _locationController.text.trim(),
    );

    try {
      var res = await http.post(
        Uri.parse(API.regShop),
        body: regShopModel.toJson(),
      );

      if (res.statusCode == 200) {
        var resBodyRegShop = jsonDecode(res.body);
        if (resBodyRegShop['regShopSuccessful'] == true) {
          String shopId = resBodyRegShop['shop_id'].toString();
          Fluttertoast.showToast(
              msg: "Your shop Successfully Registered a shop.");
          Navigator.pushReplacement(
              context, // Navigate to SellerProfilePage
              MaterialPageRoute(
                  builder: (context) => SellerHomePage(shopId: shopId)));

          // setState(() {
          //   _descController.clear();
          //   _nameController.clear();
          //   _locationController.clear();
          //   _contactController.clear();
          // }
          // );
        } else {
          Fluttertoast.showToast(
              msg: "The Shop Name alread taken, Please try another name.");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() => _image = File(pickedFile.path));
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('No image selected.')));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Shop'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Shop Name'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter Shop Name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter Shop Description'
                      : null,
                ),
                const SizedBox(height: 16),
                // Role selection
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'Select Status',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Active',
                      child: Text('Active'),
                    ),
                    DropdownMenuItem(
                      value: 'Inactive',
                      child: Text('Inactive'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a status';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter Shop Location'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contactController,
                  decoration: const InputDecoration(labelText: 'Contact Email'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter Contact Email'
                      : null,
                ),
                const SizedBox(height: 36),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Wait for validateEmail to complete
                      bool isEmailValid = await validateShopName();

                      if (isEmailValid) {
                        // Proceed to register user if email is valid
                        await registerShop();
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please use another shop name.");
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Register Shop'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
