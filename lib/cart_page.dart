import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_express/model/product.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'shop/product_controller.dart';
import 'user_provider.dart';
import 'product.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? _selectedPaymentMethod = "Online Banking"; // Default payment method
  double deliveryFee = 0.0;

  // State to track if the user has chosen a recommendation
  bool recommendationAccepted = false;

  // Calculate delivery fee based on distance
  double calculateDeliveryFee(double distance) {
    return distance <= 1.0 ? 2.0 : 3.0;
  }

  // Get the recommended store for the cheapest option
  Map<String, dynamic>? getRecommendedStore(
      Product currentProduct, List<Product> allProducts) {
    // Skip recommendation logic if a recommendation has already been accepted
    if (recommendationAccepted) return null;

    // Filter products with the same name
    final sameProducts = allProducts.where((product) {
      return product.product_name == currentProduct.product_name &&
          product != currentProduct;
    }).toList();

    if (sameProducts.isEmpty) {
      return null;
    }

    // Calculate total cost (price + delivery fee) for each product
    final recommendations = sameProducts.map((product) {
      // final totalCost =
      //     product.price + calculateDeliveryFee(product.distance);
      return {
        'storeName': product.shop_id,
        // 'totalCost': totalCost,
        'product': product,
      };
    }).toList();

    // Sort by total cost to get the cheapest
    recommendations.sort((a, b) {
      final costA = a['totalCost'] as double? ?? double.infinity;
      final costB = b['totalCost'] as double? ?? double.infinity;
      return costA.compareTo(costB);
    });

    return recommendations.isNotEmpty ? recommendations.first : null;
  }

  // Show recommendation popup
  void showRecommendationPopup(
      BuildContext context, Product recommendedProduct) {
    // final totalCost = recommendedProduct.price +
    //     calculateDeliveryFee(recommendedProduct.distance as double);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Recommendation"),
          content: Text("The cheapest option is from ${recommendedProduct.shop_id} with a total cost of RM ${recommendedProduct.price.toStringAsFixed(2)}. Would you like to choose this store?"
              // "The cheapest option is from ${recommendedProduct.shop_id} with a total cost of RM ${totalCost.toStringAsFixed(2)}. Would you like to choose this store?"
              ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Provider.of<CartProvider>(context, listen: false)
                    .replaceCartWithRecommended(recommendedProduct);
                setState(() {
                  recommendationAccepted =
                      true; // Mark recommendation as accepted
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "You selected the recommended store: ${recommendedProduct.shop_id}"),
                  ),
                );
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    // final productProvider = Provider.of<ProductProvider>(context);

    final cartItems = cartProvider.cartItems;
    // final products = productProvider.products;

    // Calculate delivery fee based on the farthest distance in the cart
    if (cartItems.isNotEmpty) {
      final maxDistance = cartItems.keys
          .map((product) => product.distance as double)
          .reduce((a, b) => a > b ? a : b);
      deliveryFee = calculateDeliveryFee(maxDistance);
    }

    // Check if a recommendation exists for the first product in the cart
    Map<String, dynamic>? recommendation;
    if (cartItems.isNotEmpty) {
      final firstProduct = cartItems.keys.first;
      // recommendation = getRecommendedStore(firstProduct, products);
    }

    // final double totalPrice = cartProvider.totalPrice + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recommendation card
            if (recommendation != null)
              GestureDetector(
                onTap: () => showRecommendationPopup(
                    context, recommendation!['product']),
                child: Card(
                  elevation: 2,
                  color: Colors.orange[50],
                  child: ListTile(
                    leading: const Icon(Icons.star, color: Colors.orange),
                    title: Text(
                      "Recommended Store: ${recommendation['storeName']}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Total Cost: RM ${recommendation['totalCost'].toStringAsFixed(2)}",
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // Item Ordered Section
            const Text(
              "Item Ordered",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartItems.keys.toList()[index];
                  final quantity = cartItems[product]!;

                  return Dismissible(
                    key: Key(product.product_name),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      cartProvider.removeFromCart(product);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${product.product_name} removed from cart!"),
                        ),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.file(
                          File(product.image_file),
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.product_name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Store: ${product.shop_id}",
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              "RM ${product.price}",
                              style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          "$quantity items",
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(),

            // Details Transaction Section
            const Text(
              "Details Transaction",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subtotal", style: TextStyle(fontSize: 16)),
                Text(
                  // "RM ${cartProvider.totalPrice.toStringAsFixed(2)}",
                  "",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Riders", style: TextStyle(fontSize: 16)),
                Text(
                  "RM ${deliveryFee.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Price",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  //"RM ${totalPrice.toStringAsFixed(2)}",
                  "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Deliver To Section
            const Text(
              "Deliver to:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text("Name: ", style: TextStyle(fontSize: 16)),
                Text(
                  userProvider.fullName ?? "No Name",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                const Text("Phone No.: ", style: TextStyle(fontSize: 16)),
                Text(
                  userProvider.phoneNumber ?? "No Phone",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              children: [
                const Text("Address: ", style: TextStyle(fontSize: 16)),
                Expanded(
                  child: Text(
                    userProvider.address ?? "No Address",
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Payment Method Dropdown
            const Text(
              "Payment Method:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: _selectedPaymentMethod,
              items: [
                "Online Banking",
                "Credit Card",
                "Cash on Delivery",
              ].map((method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (newMethod) {
                setState(() {
                  _selectedPaymentMethod = newMethod;
                });
              },
            ),
            const Spacer(),

            // Checkout Button
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Checkout Complete! Payment Method: $_selectedPaymentMethod"),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Checkout Now",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on String {
  toStringAsFixed(int i) {}
}
