import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_express/api_connection/api_connection.dart';
import 'package:http/http.dart' as http;

class AddRiderPage extends StatefulWidget {
  const AddRiderPage({Key? key}) : super(key: key);

  @override
  _AddRiderPageState createState() => _AddRiderPageState();
}

class _AddRiderPageState extends State<AddRiderPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _vehicleTypeController = TextEditingController();
  final _licensePlateController = TextEditingController();
  final _assignedOrderIdController = TextEditingController();
  final _createdAtController = TextEditingController();
  final _updatedAtController = TextEditingController();

  File? _image;
  String? _availability; // Dropdown value for availability

  Future<void> addRider() async {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: "Please fill all required fields.");
      return;
    }

    try {
      // Convert image to Base64
      String? base64Image;
      if (_image != null) {
        base64Image = base64Encode(await _image!.readAsBytes());
      }

      // Create rider data
      final riderData = {
        "name": _nameController.text.trim(),
        "vehicle_type": _vehicleTypeController.text.trim(),
        "license_plate": _licensePlateController.text.trim(),
        "availability": _availability ?? "Not Available",
        "assigned_order_id": _assignedOrderIdController.text.trim(),
        "created_at": _createdAtController.text.trim(),
        "updated_at": _updatedAtController.text.trim(),
        "image": base64Image,
      };

      // Send POST request to the server
      var res = await http.post(
        Uri.parse(API.addRider),
        body: jsonEncode(riderData),
        headers: {'Content-Type': 'application/json'},
      );

      print("Response Status: ${res.statusCode}");
      print("Response Body: ${res.body}");

      if (res.statusCode == 200) {
        var resBody = jsonDecode(res.body);

        if (resBody['riderAddSuccessful'] == true) {
          Fluttertoast.showToast(msg: "Rider added successfully.");
          setState(() {
            _formKey.currentState?.reset();
            _image = null;
            _availability = null;
          });
        } else {
          Fluttertoast.showToast(
              msg: resBody['message'] ?? "Failed to add rider.");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Server error: ${res.statusCode}. Check logs for details.");
      }
    } catch (e) {
      print("Error occurred: $e");
      Fluttertoast.showToast(msg: "An error occurred: $e");
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    } else {
      Fluttertoast.showToast(msg: "No image selected.");
    }
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final formattedDate = "${pickedDate.toLocal()}".split(' ')[0];
      setState(() {
        controller.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Rider'),
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
                  decoration: const InputDecoration(labelText: 'Rider Name'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter rider name'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _vehicleTypeController,
                  decoration: const InputDecoration(labelText: 'Vehicle Type'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter vehicle type'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _licensePlateController,
                  decoration: const InputDecoration(labelText: 'License Plate'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter license plate'
                      : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _availability,
                  decoration: const InputDecoration(labelText: 'Availability'),
                  items: ['Available', 'Not Available'].map((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (newValue) =>
                      setState(() => _availability = newValue!),
                  validator: (value) =>
                      value == null ? 'Select availability status' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _assignedOrderIdController,
                  decoration:
                      const InputDecoration(labelText: 'Assigned Order ID'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter assigned order ID'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _createdAtController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Created At',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => _selectDate(_createdAtController),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter created at'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _updatedAtController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Updated At',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => _selectDate(_updatedAtController),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter updated at'
                      : null,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Upload Image'),
                ),
                if (_image != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child:
                          Image.file(_image!, height: 150, fit: BoxFit.cover),
                    ),
                  ),
                ElevatedButton(
                  onPressed: addRider,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Add Rider'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
