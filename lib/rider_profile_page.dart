// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class RiderProfilePage extends StatefulWidget {
//   final String initialName;
//   final String initialPhone;
//   final String initialEmail;
//   final String initialAddress;

//   const RiderProfilePage({
//     Key? key,
//     required this.initialName,
//     required this.initialPhone,
//     required this.initialEmail,
//     required this.initialAddress,
//   }) : super(key: key);

//   @override
//   State<RiderProfilePage> createState() => _RiderProfilePageState();
// }

// class _RiderProfilePageState extends State<RiderProfilePage> {
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _addressController = TextEditingController();
//   File? _profilePicture;

//   @override
//   void initState() {
//     super.initState();
//     // Set initial values from RiderHomePage
//     _nameController.text = widget.initialName;
//     _emailController.text = widget.initialEmail;
//     _phoneController.text = widget.initialPhone;
//     _addressController.text = widget.initialAddress;
//   }

//   // Function to pick an image
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _profilePicture = File(pickedFile.path);
//       });
//     }
//   }

//   // Function to show a success dialog
//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Success"),
//           content: const Text("Profile Saved Successfully!"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 // Pass updated data back to RiderHomePage
//                 Navigator.pop(context, {
//                   'name': _nameController.text.trim(),
//                   'email': _emailController.text.trim(),
//                   'phone': _phoneController.text.trim(),
//                   'address': _addressController.text.trim(),
//                 });
//               },
//               child: const Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Rider Profile"),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Profile Picture
//               Center(
//                 child: GestureDetector(
//                   onTap: _pickImage,
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.orange.withOpacity(0.2),
//                     backgroundImage: _profilePicture != null
//                         ? FileImage(_profilePicture!)
//                         : null,
//                     child: _profilePicture == null
//                         ? const Icon(Icons.person,
//                             size: 50, color: Colors.orange)
//                         : null,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Full Name Field
//               const Text("Full Name",
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   hintText: "Enter your full name",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Email Field
//               const Text("Email",
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   hintText: "Enter your email",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Phone Field
//               const Text("Phone",
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _phoneController,
//                 decoration: InputDecoration(
//                   hintText: "Enter your phone number",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Address Field
//               const Text("Address",
//                   style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: _addressController,
//                 decoration: InputDecoration(
//                   hintText: "Enter your address",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Save Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     _showSuccessDialog();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: const Text(
//                     "Save",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
