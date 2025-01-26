import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_express/api_connection/api_connection.dart';
import 'package:grocery_express/model/rider.dart';
import 'package:grocery_express/rider_page.dart';
import 'package:grocery_express/userPreferences/current_user.dart';
import 'package:http/http.dart' as http;

class RegisterRiderPage extends StatefulWidget {
  const RegisterRiderPage({Key? key}) : super(key: key);

  @override
  _RegisterRiderPageState createState() => _RegisterRiderPageState();
}

class _RegisterRiderPageState extends State<RegisterRiderPage> {
  final _formKey = GlobalKey<FormState>();
  final _lplateController = TextEditingController();

  final CurrentUser currentUserInfo = Get.put(CurrentUser());

  // Role selection
  String? _selectvType;
  String? _selectStatus;
  bool _showLicensePlateField = true; // New variable to control visibility

  // File? _image;

  Future<bool> validateLicensesPlate() async {
    final license_plate = _lplateController.text;
    try {
      final response = await http.post(
        Uri.parse(API.validateLPlate),
        body: {'license_plate': license_plate},
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return responseBody['isPlateValid'] ?? true;
      } else {
        return false;
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      print("Error validating plate Licenses: $e");
      return false;
    }
  }

  registerRider() async {
    rider regRiderModel = rider(
      1,
      currentUserInfo.user.user_id,
      _selectvType!,
      _lplateController.text.trim(),
      _selectStatus!,
      "",
      "",
      "",
    );

    try {
      var res = await http.post(
        Uri.parse(API.addRider),
        body: regRiderModel.toJson(),
      );

      if (res.statusCode == 200) {
        var resBodyRegRider = jsonDecode(res.body);
        if (resBodyRegRider['riderAddSuccessful'] == true) {
          // String riderId = resBodyRegShop['rider_id'].toString();
          Fluttertoast.showToast(
              msg: "Your account successfully registered as Rider.");
          Navigator.pushReplacement(
              context, // Navigate to SellerProfilePage
              MaterialPageRoute(builder: (context) => const RiderHome()));
        } else {
          Fluttertoast.showToast(
              msg: "The licenses plate already exist, Please try another.");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Rider'),
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                // Role selection
                DropdownButtonFormField<String>(
                  value: _selectvType,
                  decoration: const InputDecoration(
                    labelText: 'Select Vehicle Type',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Van',
                      child: Text('Van'),
                    ),
                    DropdownMenuItem(
                      value: 'Car',
                      child: Text('Car'),
                    ),
                    DropdownMenuItem(
                      value: 'Motorcycle',
                      child: Text('Motorcycle'),
                    ),
                    DropdownMenuItem(
                      value: 'Bicycle',
                      child: Text('Bicycle'),
                    ),
                  ],
                  // onChanged: (value) {
                  //   setState(() {
                  //     _selectvType = value;
                  //   });
                  // },
                  onChanged: (value) {
                    setState(() {
                      _selectvType = value;
                      _showLicensePlateField =
                          value != 'Bicycle'; // Toggle visibility
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a vehicle type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // TextFormField(
                //   controller: _lplateController,
                //   decoration: const InputDecoration(labelText: 'License Plate'),
                //   validator: (value) => value == null || value.isEmpty
                //       ? 'Enter A License Plate'
                //       : null,
                // ),
                Visibility(
                  visible: _showLicensePlateField, // Control visibility
                  child: TextFormField(
                    controller: _lplateController,
                    decoration:
                        const InputDecoration(labelText: 'License Plate'),
                    validator: (value) {
                      if (_showLicensePlateField &&
                          (value == null || value.isEmpty)) {
                        return 'Enter A License Plate';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Role selection
                DropdownButtonFormField<String>(
                  value: _selectStatus,
                  decoration: const InputDecoration(
                    labelText: 'Select Status',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Available',
                      child: Text('Available'),
                    ),
                    DropdownMenuItem(
                      value: 'Unavailable',
                      child: Text('Unavailable'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectStatus = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a availability status';
                    }
                    return null;
                  },
                ),
                // const SizedBox(height: 16),
                // TextFormField(
                //   controller: _locationController,
                //   decoration: const InputDecoration(labelText: 'Location'),
                //   validator: (value) => value == null || value.isEmpty
                //       ? 'Enter Shop Location'
                //       : null,
                // ),
                // const SizedBox(height: 16),
                // TextFormField(
                //   controller: _contactController,
                //   decoration: const InputDecoration(labelText: 'Contact Email'),
                //   validator: (value) => value == null || value.isEmpty
                //       ? 'Enter Contact Email'
                //       : null,
                // ),
                const SizedBox(height: 36),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Wait for validateEmail to complete
                      bool isPlateValid = await validateLicensesPlate();

                      if (isPlateValid) {
                        // Proceed to register user if email is valid
                        await registerRider();
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please use another license plate name.");
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Register Rider'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
