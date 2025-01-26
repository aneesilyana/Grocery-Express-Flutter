// import 'dart:io'; // For File operations
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:grocery_express/model/product.dart';
// import 'package:provider/provider.dart';
// import 'product_provider.dart'; // Access products from ProductProvider
// import 'edit_product_page.dart'; // Navigate to EditProductPage
// // import 'product.dart';

// class ViewProductPage extends StatelessWidget {
//   const ViewProductPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Access the list of products from ProductProvider
//     // final productProvider = Provider.of<ProductProvider>(context);
//     // final products = productProvider.products;

//     final ProductController productList = Get.put(ProductController());

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('View Product'),
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
//       body: product.isEmpty
//           ? const Center(
//               child: Text(
//                 'No products added yet.',
//                 style: TextStyle(fontSize: 18, color: Colors.grey),
//               ),
//             )
//           : GridView.builder(
//               padding: const EdgeInsets.all(16.0),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // Two items per row
//                 crossAxisSpacing: 16.0,
//                 mainAxisSpacing: 16.0,
//                 childAspectRatio: 0.7, // Adjusted aspect ratio
//               ),
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final product = products[index];

//                 return GestureDetector(
//                   onTap: () async {
//                     // Navigate to EditProductPage when a product is tapped
//                     final updatedProduct = await Navigator.push<Product>(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => EditProductPage(product: product),
//                       ),
//                     );

//                     // // Update the product in the ProductProvider if changes are made
//                     // if (updatedProduct != null) {
//                     //   productProvider.updateProduct(updatedProduct);
//                     // }
//                   },
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     elevation: 4,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Product Image
//                         product.image_file.isNotEmpty
//                             ? ClipRRect(
//                                 borderRadius: const BorderRadius.vertical(
//                                     top: Radius.circular(10)),
//                                 child: Image.file(
//                                   File(product.image_file),
//                                   width: double.infinity,
//                                   height: 100, // Reduced height
//                                   fit: BoxFit.cover,
//                                 ),
//                               )
//                             : const Icon(
//                                 Icons.image,
//                                 size: 100,
//                                 color: Colors.grey,
//                               ),
//                         const SizedBox(height: 8),

//                         // Flexible Content
//                         Flexible(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Product Name
//                                 Text(
//                                   product.product_name,
//                                   style: const TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),

//                                 // Product Category
//                                 Text(
//                                   product.category,
//                                   style: const TextStyle(
//                                       fontSize: 12, color: Colors.grey),
//                                 ),

//                                 const SizedBox(height: 4),

//                                 // Rating and Price
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     // Rating
//                                     Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.star,
//                                           size: 14,
//                                           color: Colors.orange,
//                                         ),
//                                         Text(
//                                           product.avg_rating,
//                                           style: const TextStyle(fontSize: 12),
//                                         ),
//                                       ],
//                                     ),
//                                     // Price
//                                     Text(
//                                       'RM ${product.price}',
//                                       style: const TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                                 const SizedBox(height: 8),

//                                 // Favorite and Distance
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     // Favorite Button
//                                     // IconButton(
//                                     //   icon: Icon(
//                                     //     product.isFavorite
//                                     //         ? Icons.favorite
//                                     //         : Icons.favorite_border,
//                                     //     color: Colors.red,
//                                     //   ),
//                                     //   onPressed: () {
//                                     //     productProvider.toggleFavorite(product);
//                                     //   },
//                                     // ),

//                                     // Distance
//                                     Text(
//                                       '${product.distance} km',
//                                       style: const TextStyle(
//                                           fontSize: 12, color: Colors.grey),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
import 'dart:io'; // For File operations
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_express/api_connection/api_connection.dart';
import 'package:grocery_express/model/product.dart';
import 'package:grocery_express/shop/product_controller.dart'; // Import ProductController
import 'edit_product_page.dart'; // Navigate to EditProductPage

class ViewProductPage extends StatelessWidget {
  ViewProductPage({Key? key}) : super(key: key);

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Product'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back(); // Navigate back using GetX
          },
        ),
      ),
      body: Obx(() {
        // Observe changes in the product list
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (productController.errorMessage.isNotEmpty) {
          return Center(child: Text(productController.errorMessage.value));
        } else if (productController.productList.isEmpty) {
          return const Center(
            child: Text(
              'No products added yet.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two items per row
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.7, // Adjusted aspect ratio
            ),
            itemCount: productController.productList.length,
            itemBuilder: (context, index) {
              final product = productController.productList[index];
              final imageUrl = '${API.imageFetch}/${product.image_file}';

              return GestureDetector(
                onTap: () async {
                  // Navigate to EditProductPage when a product is tapped
                  final updatedProduct = await Get.to(
                    EditProductPage(product: product),
                  );

                  // If the product was updated, refresh the list
                  if (updatedProduct != null) {
                    productController.fetchProducts();
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      product.image_file.isNotEmpty
                          ? ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              child: Image.network(
                                imageUrl,
                                width: double.infinity,
                                height: 100, // Reduced height
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.image,
                              size: 100,
                              color: Colors.grey,
                            ),
                      const SizedBox(height: 8),

                      // Flexible Content
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Name
                              Text(
                                product.product_name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                              // Product Category
                              Text(
                                product.category,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),

                              const SizedBox(height: 4),

                              // Rating and Price
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Rating
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 14,
                                        color: Colors.orange,
                                      ),
                                      Text(
                                        product.avg_rating,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  // Price
                                  Text(
                                    'RM ${product.price}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // Favorite and Distance
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Distance
                                  Text(
                                    '${product.distance} km',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
