import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_express/api_connection/api_connection.dart';
import 'package:grocery_express/model/product.dart';
import 'shop/product_controller.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // For navigation bar

  final List<Widget> _pages = [
    HomePageContent(),
    ProfilePage(), // Add Profile Page here
  ];

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

class HomePageContent extends StatelessWidget {
  HomePageContent({Key? key}) : super(key: key);

  final ProductController productList = Get.put(ProductController());
  final categories = ['Vegetables', 'Fruits', 'Meats', 'Biscuits', 'Drinks'];
  final List<String> categoryImages = [
    'assets/vegetables.png', // Local image for "Vegetables"
    'assets/fruits.png', // Local image for "Fruits"
    'assets/meats.png', // Local image for "Meats"
    'assets/biscuits.png', // Local image for "Biscuits"
    'assets/drinks.png', // Local image for "Drinks"
  ];

  @override
  Widget build(BuildContext context) {
    // Access the provider
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Location",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.orange, size: 16),
                SizedBox(width: 4),
                Text(
                  "Pekan, Pahang",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Search feature not implemented!")),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Freshness Delivered to Your Doorstep!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            // Categories Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Find by Category",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text("See All Categories not implemented!")),
                      );
                    },
                    child: const Text("See All"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.orange.withOpacity(0.2),
                          child:
                              // const Icon(Icons.category, color: Colors.orange),
                              Image.asset(
                            categoryImages[
                                index], // Use the image corresponding to the category
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(categories[index]),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Product List Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Products",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(() {
              final controller = Get.find<ProductController>();

              // Observe changes in productController
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text(controller.errorMessage.value));
              } else if (controller.productList.isEmpty) {
                return _buildEmptyState(context);
              } else {
                return _buildProductGrid(context, controller.productList);
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            "No products added yet.",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context, List<Product> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final imageUrl = '${API.imageFetch}/${product.image_file}';
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                child: Image.network(
                  imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.product_name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "RM ${product.price}",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Shop: ${product.shop_name}",
                      style: const TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
