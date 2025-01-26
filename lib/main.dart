import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grocery_express/model/userv2.dart';
import 'package:grocery_express/register_page.dart';
import 'package:grocery_express/rider_profile.dart';
import 'package:grocery_express/shop/seller_profile.dart';
// import 'package:grocery_express/shop/seller_profile.dart';
import 'package:grocery_express/userPreferences/user_preferences.dart';
import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// Import app pages and providers
import 'login_page.dart';
import 'home_page.dart';
// import 'seller_home_page.dart';
// import 'add_product_page.dart';
// import 'view_product_page.dart';
// import 'edit_product_page.dart';
// import 'cart_page.dart'; // Import Cart Page
// import 'profile_page.dart'; // Import Profile Page
// Product Provider
import 'cart_provider.dart'; // Cart Provider
import 'user_provider.dart'; // User Provider
// import 'product.dart';
// import 'product_detail_page.dart';
// import 'personal_profile_page.dart'; // Product Detail Page

// Define constants for routes
class Routes {
  static const String login = '/login';
  static const String register = '/register';
  static const String homepage = '/homepage';
  static const String sellerHomepage = '/sellerhomepage';
  static const String addProduct = '/addProduct';
  static const String viewProduct = '/viewProduct';
  static const String editProduct = '/editProduct';
  static const String productDetail = '/productDetail';
  static const String cartPage = '/cartPage'; // Cart Page route
  static const String profilePage = '/profilePage'; // Profile Page route
  static const String riderProfile = '/riderProfile'; // Rider Profile route
  static const String personalProfilePage =
      '/personalProfilePage'; // Personal Profile Page route
  static const String sellerProfilePage = '/shop/seller_profile';
}

void main() => runApp(const AuthApp());

class AuthApp extends StatelessWidget {
  const AuthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (context) => ProductController(), // Initialize ProductProvider
        // ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(), // Initialize CartProvider
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(), // Initialize UserProvider
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grocery Express',
        theme: ThemeData(
          primarySwatch: Colors.orange, // Define the theme color
        ),

        home: FutureBuilder(
          future: RememberUserPrefs.readUserInfo(),
          builder: (context, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while the Future is resolving
              return const Center(child: CircularProgressIndicator());
            }

            if (dataSnapShot.data == null) {
              // If no user info is found, navigate to LoginPage
              return const LoginPage();
            } else {
              // User info exists, check role_id
              Users userinfo = dataSnapShot.data as Users;

              if (userinfo.role_id == 1) {
                // Navigate to Customer Home Page
                return const HomePage();
              } else if (userinfo.role_id == 2) {
                // Navigate to Seller Profile Page
                return SellerProfilePage();
              } else if (userinfo.role_id == 3) {
                // Navigate to Cart Page (Rider Page)
                return RiderProfile();
              } else {
                // Handle invalid role
                Fluttertoast.showToast(msg: "Invalid User Role");
                return const LoginPage(); // Redirect to login in case of an issue
              }
            }
          },
        ),
        getPages: [
          GetPage(name: Routes.login, page: () => const LoginPage()),
          GetPage(name: Routes.register, page: () => const RegisterPage()),
          GetPage(name: Routes.homepage, page: () => const HomePage()),
          // Add other routes here as needed
          // GetPage(name: Routes.sellerHomepage, page: () => const SellerHomePage()),
          // GetPage(name: Routes.addProduct, page: () => const AddProductPage()),
          // ...
        ],
        // initialRoute: Routes.login, // Default route
        // onGenerateRoute: (settings) {
        //   // Handle dynamic routes with arguments
        //   if (settings.name == Routes.editProduct) {
        //     final product = settings.arguments as Product; // Get product object
        //     return MaterialPageRoute(
        //       builder: (context) => EditProductPage(product: product),
        //     );
        //   } else if (settings.name == Routes.productDetail) {
        //     final product = settings.arguments as Product; // Get product object
        //     return MaterialPageRoute(
        //       builder: (context) => ProductDetailPage(product: product),
        //     );
        //   }

        //   // Static routes without arguments
        //   switch (settings.name) {
        //     case Routes.login:
        //       return MaterialPageRoute(builder: (context) => const LoginPage());
        //     case Routes.register:
        //       return MaterialPageRoute(
        //           builder: (context) => const register.RegisterPage());
        //     case Routes.homepage:
        //       return MaterialPageRoute(builder: (context) => const HomePage());
        //     case Routes.sellerHomepage:
        //       return MaterialPageRoute(
        //           builder: (context) => const SellerHomePage());
        //     case Routes.addProduct:
        //       return MaterialPageRoute(
        //           builder: (context) => const AddProductPage());
        //     case Routes.viewProduct:
        //       return MaterialPageRoute(
        //           builder: (context) => const ViewProductPage());
        //     case Routes.cartPage:
        //       return MaterialPageRoute(builder: (context) => const CartPage());
        //     case Routes.profilePage:
        //       return MaterialPageRoute(
        //           builder: (context) => const ProfilePage());
        //     case Routes.personalProfilePage:
        //       return MaterialPageRoute(
        //           builder: (context) => const PersonalProfilePage());
        //     case Routes.sellerProfilePage:
        //       return MaterialPageRoute(
        //           builder: (context) => const SellerProfilePage());
        //     default:
        //       return MaterialPageRoute(builder: (context) => const LoginPage());
        //   }
        // },
      ),
    );
  }
}
