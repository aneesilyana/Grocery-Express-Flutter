// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:grocery_express/api_connection/api_connection.dart';
// // import 'package:grocery_express/home_page.dart';
// import 'package:grocery_express/model/product.dart';
// import 'package:http/http.dart' as http;

// // class ProductProvider extends ChangeNotifier {
// //   final List<Product> _products = []; // List to hold all products

// //   List<Product> get products => _products;

// //   // Method to retrieve products by category
// //   List<Product> getProductsByCategory(String category) {
// //     return _products.where((product) => product.category == category).toList();
// //   }

// //   // Add a new product
// //   void addProduct(Product product) {
// //     _products.add(product);
// //     notifyListeners();
// //   }

// //   // Update an existing product
// //   void updateProduct(Product updatedProduct) {
// //     final index =
// //         _products.indexWhere((product) => product.product_name == updatedProduct.product_name);

// //     if (index != -1) {
// //       _products[index] = updatedProduct;
// //       notifyListeners();
// //     }
// //   }

// //   // Delete a product
// //   void deleteProduct(Product product) {
// //     _products.remove(product);
// //     notifyListeners();
// //   }

// //   // // Mark a product as favorite or unfavorite
// //   // void toggleFavorite(Product product) {
// //   //   final index = _products.indexOf(product);
// //   //   if (index != -1) {
// //   //     _products[index].isFavorite = !_products[index].isFavorite;
// //   //     notifyListeners();
// //   //   }
// //   // }

// //   // // Get all favorite products
// //   // List<Product> get favoriteProducts {
// //   //   return _products.where((product) => product.isFavorite).toList();
// //   // }
// // }

// // Product provider
// // class ProductProvider with ChangeNotifier {
// //   List<Product> _products = [];

// //   List<Product> get products => _products;

// //   Future<void> loadProducts() async {
// //     try {
// //       _products = await ProductService.fetchProducts();
// //       notifyListeners();
// //     } catch (e) {
// //       _products = [];
// //       notifyListeners();
// //       rethrow;
// //     }
// //   }
// // }

// class ProductProvider with ChangeNotifier {
//   List<Product> _products = [];
//   bool _isLoading = false;
//   String? _error;

//   List<Product> get products => _products;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<void> fetchProducts() async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     try {
//       final response = await http.get(Uri.parse(API.fetchDataProd));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['success']) {
//           _products = (data['products'] as List)
//               .map((product) => Product.fromJson(product))
//               .toList();
//         } else {
//           _error = "No products found.";
//         }
//       } else {
//         _error = "Failed to fetch products.";
//       }
//     } catch (e) {
//       _error = "Error: $e";
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:grocery_express/model/product.dart'; // Import Product model
import 'package:grocery_express/api_connection/api_connection.dart'; // Import API constants
import 'dart:convert';
import 'package:http/http.dart' as http;

// class ProductController extends GetxController {
//   RxList<Product> productList = <Product>[].obs; // Observable list for products
//   RxBool isLoading = false.obs; // Observable to track loading state
//   RxString errorMessage = ''.obs; // Observable for error messages

//   // Product get product => productList.value;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchProducts(); // Fetch products when the controller is initialized
//   }

//   // Fetch products from the API
//   Future<void> fetchProducts() async {
//     if (productList.isNotEmpty) return; // skip if data exist

//     isLoading.value = true;
//     errorMessage.value = '';

//     try {
//       final response = await http.get(Uri.parse(API.fetchDataProd));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['success']) {
//           // Cast `data['products']` to a List<dynamic> before mapping
//           final List<dynamic> productJsonList = data['products'];
//           productList.value = productJsonList
//               .map((productJson) => Product.fromJson(productJson))
//               .toList();
//         } else {
//           errorMessage.value = 'No products found.';
//         }
//       } else {
//         errorMessage.value =
//             'Failed to fetch products. Status code: ${response.statusCode}';
//       }
//     } catch (e) {
//       errorMessage.value = 'Error: $e';
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Clear product list
//   void clearProducts() {
//     productList.clear();
//   }
// }
class ProductController extends GetxController {
  RxList<Product> productList = <Product>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts(); // Initial fetch
    debounce(
      productList,
      (_) => fetchProducts(), // Auto-fetch when productList changes
      time: const Duration(minutes: 1),
    ); // Set up auto-refresh every 5 minutes
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await http.get(Uri.parse(API.fetchDataProd));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          final List<dynamic> productJsonList = data['products'];
          productList.value = productJsonList
              .map((productJson) => Product.fromJson(productJson))
              .toList();
        } else {
          errorMessage.value = 'No products found.';
        }
      } else {
        errorMessage.value =
            'Failed to fetch products. Status code: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void clearProducts() {
    productList.clear();
  }
}
