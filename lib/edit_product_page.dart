import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_express/model/product.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProductPage extends StatefulWidget {
  final Product product;

  const EditProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _distanceController;
  late TextEditingController _ratingController;
  late TextEditingController _storeNameController;

  File? _image;
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with product's current values
    _nameController = TextEditingController(text: widget.product.product_name);
    _priceController = TextEditingController(text: widget.product.price);
    _descriptionController =
        TextEditingController(text: widget.product.description);
    _distanceController =
        TextEditingController(text: widget.product.distance.toString());
    _ratingController =
        TextEditingController(text: widget.product.avg_rating.toString());
    _storeNameController =
        TextEditingController(text: widget.product.shop_id.toString());
    _selectedCategory = widget.product.category;

    _image = widget.product.image_file.isNotEmpty
        ? File(widget.product.image_file)
        : null;
  }

  // Pick a new image for the product
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected.')),
      );
    }
  }

  // Save changes to the product
  void _saveChanges(BuildContext context) {
    if (_validateInputs()) {
      // final updatedProduct = Product(
      //   product_name: _nameController.text.trim(),
      //   price: double.parse(_priceController.text.trim()),
      //   description: _descriptionController.text.trim(),
      //   imagePath: _image?.path ?? widget.product.image_file,
      //   category: _selectedCategory,
      //   distance: double.parse(_distanceController.text.trim()),
      //   rating: double.parse(_ratingController.text.trim()),
      //   storeName: _storeNameController.text.trim(),
      // );

      // Update the product in ProductProvider
      // Provider.of<ProductProvider>(context, listen: false)
      //     .updateProduct(updatedProduct);

      // Show confirmation and go back
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product updated successfully!')),
      );
      Navigator.pop(context);
    }
  }

  // Validate user inputs
  bool _validateInputs() {
    if (_nameController.text.trim().isEmpty) {
      _showError('Product name cannot be empty.');
      return false;
    }
    if (double.tryParse(_priceController.text.trim()) == null ||
        double.parse(_priceController.text.trim()) <= 0) {
      _showError('Please enter a valid price greater than 0.');
      return false;
    }
    if (_descriptionController.text.trim().isEmpty) {
      _showError('Description cannot be empty.');
      return false;
    }
    if (double.tryParse(_distanceController.text.trim()) == null ||
        double.parse(_distanceController.text.trim()) <= 0) {
      _showError('Please enter a valid distance.');
      return false;
    }
    if (double.tryParse(_ratingController.text.trim()) == null ||
        double.parse(_ratingController.text.trim()) < 0 ||
        double.parse(_ratingController.text.trim()) > 5) {
      _showError('Please enter a valid rating (0 to 5).');
      return false;
    }
    if (_storeNameController.text.trim().isEmpty) {
      _showError('Store name cannot be empty.');
      return false;
    }
    if (_image == null && widget.product.image_file.isEmpty) {
      _showError('Please upload an image.');
      return false;
    }
    return true;
  }

  // Show error message
  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['Vegetables', 'Fruits', 'Meats', 'Biscuits', 'Drinks'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _distanceController,
                decoration: const InputDecoration(labelText: 'Distance (km)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _ratingController,
                decoration: const InputDecoration(labelText: 'Rating (0-5)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _storeNameController,
                decoration: const InputDecoration(labelText: 'Store Name'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Change Image'),
              ),
              if (_image != null) ...[
                const SizedBox(height: 16),
                Center(
                  child: Image.file(
                    _image!,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _saveChanges(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
