// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:grocery_express/userPreferences/current_user.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:grocery_express/api_connection/api_connection.dart';
// import 'package:grocery_express/model/product.dart';
// import 'package:http/http.dart' as http;

// class AddProductPage extends StatefulWidget {
//   const AddProductPage({Key? key}) : super(key: key);

//   @override
//   _AddProductPageState createState() => _AddProductPageState();
// }

// class _AddProductPageState extends State<AddProductPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _qtyController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _imagePathController = TextEditingController();
//   final _distanceController = TextEditingController();
//   final _ratingController = TextEditingController();

//   final CurrentUser currentUserInfo = Get.put(CurrentUser());

//   File? _image;
//   String? _selectedCategory;
//   String? _selectStatus;

//   // Future<void> addAProduct() async {
//   //   if (_formKey.currentState?.validate() ?? false) {
//   //     String? encodedImage;

//   //     // Convert image to Base64 if available
//   //     if (_image != null) {
//   //       try {
//   //         final bytes = await _image!.readAsBytes();
//   //         encodedImage = base64Encode(bytes);
//   //       } catch (e) {
//   //         Fluttertoast.showToast(msg: "Error reading image file: $e");
//   //         return;
//   //       }
//   //     }

//   //     // Create the product model
//   //     AddProduct prodModel = AddProduct(
//   //       1, // Placeholder ID, update logic as needed
//   //       _nameController.text.trim(),
//   //       _priceController.text.trim(),
//   //       _descriptionController.text.trim(),
//   //       _distanceController.text.trim(),
//   //       _ratingController.text.trim(),
//   //       _storeNameController.text.trim(),
//   //       _selectedCategory ?? '',
//   //       (encodedImage ?? '')
//   //           as Uint8List?, // Use an empty string if no image is selected
//   //       _shopIdController.text.trim(),
//   //     );

//   //     try {
//   //       var res = await http.post(
//   //         Uri.parse(API.signUp), // Update with the correct endpoint
//   //         body: jsonEncode(prodModel.toJson()), // Ensure data is sent as JSON
//   //         headers: {'Content-Type': 'application/json'}, // Set JSON header
//   //       );

//   //       if (res.statusCode == 200) {
//   //         var resBody = jsonDecode(res.body);

//   //         if (resBody['prodAddSuccessful'] == true) {
//   //           Fluttertoast.showToast(msg: "Product added successfully.");

//   //           // Clear the form and reset state
//   //           setState(() {
//   //             _nameController.clear();
//   //             _priceController.clear();
//   //             _descriptionController.clear();
//   //             _distanceController.clear();
//   //             _ratingController.clear();
//   //             _storeNameController.clear();
//   //             _shopIdController.clear();
//   //             _selectedCategory = null;
//   //             _image = null;
//   //           });
//   //         } else {
//   //           Fluttertoast.showToast(msg: "Failed to add product.");
//   //         }
//   //       } else {
//   //         Fluttertoast.showToast(
//   //             msg: "Server error: ${res.statusCode}. Please try again.");
//   //       }
//   //     } catch (e) {
//   //       Fluttertoast.showToast(msg: "An error occurred: $e");
//   //     }
//   //   } else {
//   //     Fluttertoast.showToast(msg: "Please fill out all required fields.");
//   //   }
//   // }

//   addAProduct() async {
//     Product prodModel = Product(
//       1,
//       currentUserInfo.user.user_id,
//       _nameController.text.trim(),
//       _priceController.text.trim(),
//       _qtyController.text.trim(),
//       _descriptionController.text.trim(),
//       "",
//       "",
//       _selectStatus!,
//       _selectedCategory!,
//       _imagePathController.text.trim(),
//       _distanceController.text.trim(),
//       _ratingController.text.trim(),
//     );

//     try {
//       var res = await http.post(
//         Uri.parse(API.addProd),
//         body: prodModel.toJson(),
//       );

//       if (res.statusCode == 200) {
//         var resBodyAddProd = jsonDecode(res.body);
//         if (resBodyAddProd['addProdSuccessful'] == true) {
//           Fluttertoast.showToast(msg: "A Product Successfully Added.");

//           setState(() {
//             _nameController.clear();
//             _priceController.clear();
//             _qtyController.clear();
//             _descriptionController.clear();
//             _distanceController.clear();
//             _selectStatus = null;
//             _imagePathController.clear();
//             _distanceController.clear();
//             _ratingController.clear();
//             _selectedCategory = null;
//           });
//         } else {
//           Fluttertoast.showToast(msg: "Error Occured, Please Try Again.");
//         }
//       }
//     } catch (e) {
//       print(e.toString());
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() => _image = File(pickedFile.path));
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('No image selected.')));
//     }
//   }

//   // void _addProduct() {
//   //   if (_formKey.currentState!.validate() && _image != null) {
//   //     final product = Product(
//   //       name: _nameController.text.trim(),
//   //       price: double.parse(_priceController.text.trim()),
//   //       description: _descriptionController.text.trim(),
//   //       imagePath: _image!.path,
//   //       category: _selectedCategory,
//   //       distance: double.parse(_distanceController.text.trim()),
//   //       rating: double.parse(_ratingController.text.trim()),
//   //       storeName: _storeNameController.text.trim(),
//   //     );

//   //     Provider.of<ProductProvider>(context, listen: false).addProduct(product);
//   //     Navigator.pop(context);
//   //   } else if (_image == null) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(content: Text('Please upload an image.')));
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // final categories = ['Vegetables', 'Fruits', 'Meats', 'Biscuits', 'Drinks'];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Product'),
//         backgroundColor: Colors.orange,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back,
//               color: Colors.black), // Customize the icon and color
//           onPressed: () {
//             // Define what happens when the button is pressed
//             Get.back();
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: const InputDecoration(labelText: 'Product Name'),
//                   validator: (value) => value == null || value.isEmpty
//                       ? 'Enter product name'
//                       : null,
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _priceController,
//                   decoration: const InputDecoration(labelText: 'Price'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     final price = double.tryParse(value ?? '');
//                     return price == null || price <= 0
//                         ? 'Enter a valid price'
//                         : null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _qtyController,
//                   decoration: const InputDecoration(labelText: 'Quantity'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     final price = double.tryParse(value ?? '');
//                     return price == null || price <= 0
//                         ? 'Enter available quantity'
//                         : null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _descriptionController,
//                   decoration: const InputDecoration(labelText: 'Description'),
//                   maxLines: 3,
//                   validator: (value) => value == null || value.isEmpty
//                       ? 'Enter description'
//                       : null,
//                 ),
//                 const SizedBox(height: 16),
//                 // Role selection
//                 DropdownButtonFormField<String>(
//                   value: _selectStatus,
//                   decoration: const InputDecoration(
//                     labelText: 'Select Status',
//                     border: OutlineInputBorder(),
//                   ),
//                   items: const [
//                     DropdownMenuItem(
//                       value: 'Available',
//                       child: Text('Available'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Out of Stock',
//                       child: Text('Out of Stock'),
//                     ),
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       _selectStatus = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please select a status';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 // Role selection
//                 DropdownButtonFormField<String>(
//                   value: _selectedCategory,
//                   decoration: const InputDecoration(
//                     labelText: 'Select Category',
//                     border: OutlineInputBorder(),
//                   ),
//                   items: const [
//                     DropdownMenuItem(
//                       value: 'Vegetables',
//                       child: Text('Vegetables'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Fruits',
//                       child: Text('Fruits'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Meats',
//                       child: Text('Meats'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Biscuits',
//                       child: Text('Biscuits'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Drinks',
//                       child: Text('Drinks'),
//                     ),
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedCategory = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please select a category';
//                     }
//                     return null;
//                   },
//                 ),

//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _distanceController,
//                   decoration: const InputDecoration(labelText: 'Distance (km)'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     final distance = double.tryParse(value ?? '');
//                     return distance == null || distance <= 0
//                         ? 'Enter a valid distance'
//                         : null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _ratingController,
//                   decoration: const InputDecoration(labelText: 'Rating (0-5)'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     final rating = double.tryParse(value ?? '');
//                     return rating == null || rating < 0 || rating > 5
//                         ? 'Enter a valid rating (0-5)'
//                         : null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _pickImage,
//                   child: const Text('Upload Image'),
//                 ),
//                 if (_image != null)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16.0),
//                     child: Center(
//                       child:
//                           Image.file(_image!, height: 150, fit: BoxFit.cover),
//                     ),
//                   ),
//                 ElevatedButton(
//                   onPressed: addAProduct,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: const Text('Add Product'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//////////////////////////////////////WORK ADD PRODUCT WITHOUT IMAGE 19012025////////////////////////////////////////
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:grocery_express/userPreferences/current_user.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:grocery_express/api_connection/api_connection.dart';
// import 'package:grocery_express/model/product.dart';
// import 'package:http/http.dart' as http;

// class AddProductPage extends StatefulWidget {
//   const AddProductPage({Key? key}) : super(key: key);

//   @override
//   _AddProductPageState createState() => _AddProductPageState();
// }

// class _AddProductPageState extends State<AddProductPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _qtyController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _imagePathController = TextEditingController();
//   final _distanceController = TextEditingController();
//   final _ratingController = TextEditingController();

//   final CurrentUser currentUserInfo = Get.put(CurrentUser());

//   File? _image;
//   String? _selectedCategory;
//   String? _selectStatus;

//   addAProduct() async {
//     Product prodModel = Product(
//       1,
//       currentUserInfo.user.user_id,
//       _nameController.text.trim(),
//       _priceController.text.trim(),
//       _qtyController.text.trim(),
//       _descriptionController.text.trim(),
//       "",
//       "",
//       _selectStatus!,
//       _selectedCategory!,
//       _imagePathController.text.trim(),
//       _distanceController.text.trim(),
//       _ratingController.text.trim(),
//     );

//     try {
//       var res = await http.post(
//         Uri.parse(API.addProd),
//         body: prodModel.toJson(),
//       );

//       if (res.statusCode == 200) {
//         var resBodyAddProd = jsonDecode(res.body);
//         if (resBodyAddProd['addProdSuccessful'] == true) {
//           Fluttertoast.showToast(msg: "A Product Successfully Added.");

//           setState(() {
//             _nameController.clear();
//             _priceController.clear();
//             _qtyController.clear();
//             _descriptionController.clear();
//             _distanceController.clear();
//             _selectStatus = null;
//             _imagePathController.clear();
//             _distanceController.clear();
//             _ratingController.clear();
//             _selectedCategory = null;
//           });
//         } else {
//           Fluttertoast.showToast(msg: "Error Occured, Please Try Again.");
//         }
//       }
//     } catch (e) {
//       print(e.toString());
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() => _image = File(pickedFile.path));
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('No image selected.')));
//     }
//   }

// Future uploadImage() async {
//     final uri = Uri.parse(API.addProd);
//     var request = http.MultipartRequest('POST', uri);
//     request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
//     var response = await request.send();
//     if (response.statusCode == 200) {
//       print('Image uploaded');
//     } else {
//       print('Image not uploaded');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Product'),
//         backgroundColor: Colors.orange,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back,
//               color: Colors.black), // Customize the icon and color
//           onPressed: () {
//             // Define what happens when the button is pressed
//             Get.back();
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: const InputDecoration(labelText: 'Product Name'),
//                   validator: (value) => value == null || value.isEmpty
//                       ? 'Enter product name'
//                       : null,
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _priceController,
//                   decoration: const InputDecoration(labelText: 'Price'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     final price = double.tryParse(value ?? '');
//                     return price == null || price <= 0
//                         ? 'Enter a valid price'
//                         : null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _qtyController,
//                   decoration: const InputDecoration(labelText: 'Quantity'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     final price = double.tryParse(value ?? '');
//                     return price == null || price <= 0
//                         ? 'Enter available quantity'
//                         : null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _descriptionController,
//                   decoration: const InputDecoration(labelText: 'Description'),
//                   maxLines: 3,
//                   validator: (value) => value == null || value.isEmpty
//                       ? 'Enter description'
//                       : null,
//                 ),
//                 const SizedBox(height: 16),
//                 // Role selection
//                 DropdownButtonFormField<String>(
//                   value: _selectStatus,
//                   decoration: const InputDecoration(
//                     labelText: 'Select Status',
//                     border: OutlineInputBorder(),
//                   ),
//                   items: const [
//                     DropdownMenuItem(
//                       value: 'Available',
//                       child: Text('Available'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Out of Stock',
//                       child: Text('Out of Stock'),
//                     ),
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       _selectStatus = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please select a status';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 // Role selection
//                 DropdownButtonFormField<String>(
//                   value: _selectedCategory,
//                   decoration: const InputDecoration(
//                     labelText: 'Select Category',
//                     border: OutlineInputBorder(),
//                   ),
//                   items: const [
//                     DropdownMenuItem(
//                       value: 'Vegetables',
//                       child: Text('Vegetables'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Fruits',
//                       child: Text('Fruits'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Meats',
//                       child: Text('Meats'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Biscuits',
//                       child: Text('Biscuits'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Drinks',
//                       child: Text('Drinks'),
//                     ),
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedCategory = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please select a category';
//                     }
//                     return null;
//                   },
//                 ),

//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _distanceController,
//                   decoration: const InputDecoration(labelText: 'Distance (km)'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     final distance = double.tryParse(value ?? '');
//                     return distance == null || distance <= 0
//                         ? 'Enter a valid distance'
//                         : null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   controller: _ratingController,
//                   decoration: const InputDecoration(labelText: 'Rating (0-5)'),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     final rating = double.tryParse(value ?? '');
//                     return rating == null || rating < 0 || rating > 5
//                         ? 'Enter a valid rating (0-5)'
//                         : null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _pickImage,
//                   child: const Text('Upload Image'),
//                 ),
//                 if (_image != null)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16.0),
//                     child: Center(
//                       child:
//                           Image.file(_image!, height: 150, fit: BoxFit.cover),
//                     ),
//                   ),
//                 ElevatedButton(
//                   onPressed: addAProduct,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: const Text('Add Product'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
///////////////////////////////////////END HERE///////////////////////////////////////////////////////////////////////
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_express/userPreferences/current_user.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_express/api_connection/api_connection.dart';
import 'package:grocery_express/model/product.dart';
import 'package:http/http.dart' as http;

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _qtyController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _distanceController = TextEditingController();
  final _ratingController = TextEditingController();

  final CurrentUser currentUserInfo = Get.put(CurrentUser());

  String? _selectedCategory;
  String? _selectStatus;
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      Fluttertoast.showToast(msg: 'No image selected.');
    }
  }

  // Future<void> addProduct() async {
  //   if (_formKey.currentState!.validate() && _imageFile != null) {
  //     try {
  //       var request = http.MultipartRequest('POST', Uri.parse(API.addProd));

  //       Product prodModel = Product(
  //         1,
  //         currentUserInfo.user.user_id,
  //         _nameController.text.trim(),
  //         _priceController.text.trim(),
  //         _qtyController.text.trim(),
  //         _descriptionController.text.trim(),
  //         "",
  //         "",
  //         _selectStatus!,
  //         _selectedCategory!,
  //         _imageFile!.path,
  //         _distanceController.text.trim(),
  //         _ratingController.text.trim(),
  //       );

  //       // Attach the image file
  //       request.files.add(await http.MultipartFile.fromPath(
  //         'image_file', // This must match the key in your PHP script
  //         _imageFile!.path,
  //       ));

  //       var response = await http.post(
  //         Uri.parse(API.addProd),
  //         body: prodModel.toJson(),
  //       );

  //       if (response.statusCode == 200) {
  //         Fluttertoast.showToast(msg: "Product added successfully.");
  //         _clearForm();
  //       } else {
  //         Fluttertoast.showToast(msg: "Failed to add product.");
  //       }
  //     } catch (e) {
  //       Fluttertoast.showToast(msg: "Error: $e");
  //     }
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "Please fill all fields and select an image.");
  //   }
  // }
  // Future<void> addProduct() async {
  //   if (_formKey.currentState!.validate() && _imageFile != null) {
  //     try {
  //       // Create a Product object using the form data
  //       Product product = Product(
  //         0, // Product ID is auto-generated, so set to 0 or ignore it.
  //         currentUserInfo.user.user_id,
  //         _nameController.text.trim(),
  //         _priceController.text.trim(),
  //         _qtyController.text.trim(),
  //         _descriptionController.text.trim(),
  //         "", // Created_at
  //         "", // Updated_at
  //         _selectStatus!,
  //         _selectedCategory!,
  //         "", // Temporary placeholder for the image path
  //         _distanceController.text.trim(),
  //         _ratingController.text.trim(),
  //       );

  //       // Prepare the MultipartRequest
  //       var request = http.MultipartRequest('POST', Uri.parse(API.addProd));

  //       // Attach the product data fields using the `Product` model's `toJson` method
  //       request.fields.addAll(product.toJson());

  //       // Attach the image file
  //       request.files.add(await http.MultipartFile.fromPath(
  //         'image_file', // This matches the key in the PHP script
  //         _imageFile!.path,
  //       ));

  //       // Send the request
  //       var response = await request.send();

  //       // Handle the response
  //       if (response.statusCode == 200) {
  //         var responseBody = await http.Response.fromStream(response);
  //         var responseData = jsonDecode(responseBody.body);

  //         if (responseData['addProdSuccessful'] == true) {
  //           Fluttertoast.showToast(msg: "Product added successfully.");
  //           _clearForm();
  //         } else {
  //           Fluttertoast.showToast(
  //               msg: "Failed to add product: ${responseData['error']}");
  //         }
  //       } else {
  //         Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
  //       }
  //     } catch (e) {
  //       Fluttertoast.showToast(msg: "Error: $e");
  //     }
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "Please fill all fields and select an image.");
  //   }
  // }
  Future<void> addProduct() async {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      try {
        // Create a Product object using the form data
        Product product = Product(
          0, // Product ID is auto-generated by the server.
          currentUserInfo.user.user_id, // Shop owner ID (seller ID)
          _nameController.text.trim(),
          _priceController.text.trim(),
          _qtyController.text.trim(),
          _descriptionController.text.trim(),
          "", // created_at - will be set on the server
          "", // updated_at - will be set on the server
          _selectStatus!,
          _selectedCategory!,
          "", // Image path will be set after upload
          _distanceController.text.trim(),
          _ratingController.text.trim(),
          "",
        );

        // Prepare the MultipartRequest
        var request = http.MultipartRequest('POST', Uri.parse(API.addProd));

        // Attach the product data fields using the `Product` model's `toJson` method
        Map<String, String> fields = product.toJson()
          ..remove('shop_name'); // Remove shop_name from the fields
        request.fields.addAll(fields);

        // Attach the image file
        request.files.add(await http.MultipartFile.fromPath(
          'image_file', // This matches the key in the PHP script
          _imageFile!.path,
        ));

        // Send the request
        var response = await request.send();

        // Handle the response
        if (response.statusCode == 200) {
          var responseBody = await http.Response.fromStream(response);
          var responseData = jsonDecode(responseBody.body);

          if (responseData['addProdSuccessful'] == true) {
            Fluttertoast.showToast(msg: "Product added successfully.");
            _clearForm();
          } else {
            Fluttertoast.showToast(
                msg: "Failed to add product: ${responseData['error']}");
          }
        } else {
          Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Error: $e");
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please fill all fields and select an image.");
    }
  }

  void _clearForm() {
    setState(() {
      _nameController.clear();
      _priceController.clear();
      _qtyController.clear();
      _descriptionController.clear();
      _distanceController.clear();
      _ratingController.clear();
      _selectedCategory = null;
      _selectStatus = null;
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
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
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter product name'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final price = double.tryParse(value ?? '');
                    return price == null || price <= 0
                        ? 'Enter a valid price'
                        : null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _qtyController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final qty = int.tryParse(value ?? '');
                    return qty == null || qty <= 0
                        ? 'Enter available quantity'
                        : null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter description'
                      : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectStatus,
                  decoration: const InputDecoration(
                    labelText: 'Select Status',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'Available', child: Text('Available')),
                    DropdownMenuItem(
                        value: 'Out of Stock', child: Text('Out of Stock')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectStatus = value;
                    });
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please select a status'
                      : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Select Category',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'Vegetables', child: Text('Vegetables')),
                    DropdownMenuItem(value: 'Fruits', child: Text('Fruits')),
                    DropdownMenuItem(value: 'Meats', child: Text('Meats')),
                    DropdownMenuItem(
                        value: 'Biscuits', child: Text('Biscuits')),
                    DropdownMenuItem(value: 'Drinks', child: Text('Drinks')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please select a category'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _distanceController,
                  decoration: const InputDecoration(labelText: 'Distance (km)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final distance = double.tryParse(value ?? '');
                    return distance == null || distance <= 0
                        ? 'Enter a valid distance'
                        : null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _ratingController,
                  decoration: const InputDecoration(labelText: 'Rating (0-5)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final rating = double.tryParse(value ?? '');
                    return rating == null || rating < 0 || rating > 5
                        ? 'Enter a valid rating (0-5)'
                        : null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Upload Image'),
                ),
                if (_imageFile != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Image.file(_imageFile!,
                          height: 150, fit: BoxFit.cover),
                    ),
                  ),
                ElevatedButton(
                  onPressed: addProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
