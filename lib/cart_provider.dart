import 'package:flutter/material.dart';
import 'package:grocery_express/model/product.dart';


class CartProvider extends ChangeNotifier {
  final Map<Product, int> _cartItems = {};
  final List<Map<String, dynamic>> _completedOrders = [];

  Map<Product, int> get cartItems => _cartItems;
  List<Map<String, dynamic>> get completedOrders => _completedOrders;

  void addToCart(Product product, int quantity) {
    if (_cartItems.containsKey(product)) {
      _cartItems[product] = _cartItems[product]! + quantity;
    } else {
      _cartItems[product] = quantity;
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // double get totalPrice {
  //   return _cartItems.entries
  //       .map((item) => item.key.price * item.value)
  //       .fold(0.0, (sum, itemPrice) => sum + itemPrice);
  // }

  void completeOrder(String orderId) {
    if (_cartItems.isNotEmpty) {
      _completedOrders.add({
        'orderId': orderId,
        'items': _cartItems.entries.map((entry) {
          return {
            'name': entry.key.product_name,
            'quantity': entry.value,
            'price': entry.key.price * entry.value,
            'storeName': entry.key.shop_id,
          };
        }).toList(),
        // 'totalPrice': totalPrice,
      });
      clearCart();
    }
  }

  /// Get recommended store for a specific product
  Map<String, dynamic> getRecommendedStoreForProduct(
      String productName, double deliveryFee) {
    final matchingProducts = _cartItems.keys
        .where((product) => product.product_name == productName)
        .toList();

    if (matchingProducts.isEmpty) {
      return {};
    }

    Product? cheapestProduct;
    double lowestCost = double.infinity;

    for (var product in matchingProducts) {
      // double totalCost = product.price + deliveryFee;
      // if (totalCost < lowestCost) {
      //   lowestCost = totalCost;
      //   cheapestProduct = product;
      // }
    }

    if (cheapestProduct != null) {
      return {
        'storeName': cheapestProduct.shop_id,
        'totalCost': lowestCost,
        'product': cheapestProduct
      };
    }

    return {};
  }

  void replaceCartWithRecommended(Product recommendedProduct) {
    clearCart();
    addToCart(recommendedProduct, 1);
    notifyListeners();
  }
}
