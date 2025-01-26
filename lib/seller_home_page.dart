// import 'package:flutter/material.dart';
// import 'package:grocery_express/shop/seller_profile.dart';
// import 'package:provider/provider.dart';
// import 'add_product_page.dart';
// import 'view_product_page.dart';
// import 'edit_product_page.dart'; // Correctly importing EditProductPage
// import 'product_provider.dart'; // Used for accessing the ProductProvider

// class SellerHomePage extends StatefulWidget{
//   final String shopId;
//   const SellerHomePage({Key? key, required this.shopId}) : super(key: key);

//   State<SellerHomePage> createState() => _SellerPageState();
// }

// class _SellerPageState extends State<SellerHomePage> {
//   int _currentIndex = 0; // For navigation bar

//   final List<Widget> _pages = [
//     SellerHomePage(shopId: ),
//     SellerProfilePage(), // Add Profile Page here
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         selectedItemColor: Colors.orange,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }

// class SellerHomePageContent extends StatelessWidget {
//   final String shopId;
//   const SellerHomePageContent({Key? key, required this.shopId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);

//     return Scaffold(
//         title: Text('Seller Dashboard : ${shopId}'),
//         // title: Text('Seller Dashboard : $shopId'),
//         backgroundColor: Colors.orange,
//       );
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min, // Center contents vertically
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const AddProductPage(),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.orange,
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 ),
//                 child: const Text(
//                   'Add Product',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const ViewProductPage(),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.orange,
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 ),
//                 child: const Text(
//                   'View Products',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   if (productProvider.products.isNotEmpty) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => EditProductPage(
//                           product: productProvider.products.first,
//                         ),
//                       ),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('No products available to edit.'),
//                       ),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.orange,
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 ),
//                 child: const Text(
//                   'Edit Product',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_express/shop/seller_profile.dart';
import 'package:grocery_express/shop/shop_controller.dart';
import 'package:grocery_express/userPreferences/current_user.dart';
import 'add_product_page.dart';
import 'view_product_page.dart';
import 'edit_product_page.dart';
// import 'product_controller.dart'; // Used for accessing the ProductProvider
// import 'package:provider/provider.dart';

class SellerHomePage extends StatefulWidget {
  final String shopId;

  const SellerHomePage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<SellerHomePage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerHomePage> {
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      SellerHomePageContent(shopId: widget.shopId),
      SellerProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.orange,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class SellerHomePageContent extends StatelessWidget {
  final String shopId;

  final CurrentUser currentShopInfo = Get.put(CurrentUser());

  final ShopController shopController = Get.put(ShopController());

  SellerHomePageContent({Key? key, required this.shopId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Seller Dashboard ${shopController.currentShopInfo.value.shop_name}'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.black), // Customize the icon and color
          onPressed: () {
            // Define what happens when the button is pressed
            Get.back();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Center contents vertically
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddProductPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Add Product',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewProductPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'View Products',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () {
              //     if (productProvider.products.isNotEmpty) {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => EditProductPage(
              //             product: productProvider.products.first,
              //           ),
              //         ),
              //       );
              //     } else {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(
              //           content: Text('No products available to edit.'),
              //         ),
              //       );
              //     }
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.orange,
              //     padding: const EdgeInsets.symmetric(vertical: 16.0),
              //   ),
              //   child: const Text(
              //     'Edit Product',
              //     style: TextStyle(fontSize: 18),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
