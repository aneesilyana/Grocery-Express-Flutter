// import 'package:flutter/material.dart';
// import 'package:grocery_express/rider_profile.dart';
// import 'rider_profile_page.dart';
// import 'rider_orders_page.dart';

// class RiderHomePage extends StatefulWidget {
//   const RiderHomePage({Key? key}) : super(key: key);

//   @override
//   State<RiderHomePage> createState() => _RiderPageState();
// }

// class _RiderPageState extends State<RiderHomePage> {
//   int _currentIndex = 0;

//   late List<Widget> _pages;

//   @override
//   void initState() {
//     super.initState();
//     _pages = [
//       RiderHomePage(),
//       RiderProfile(),
//     ];
//   }

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

// class _RiderHomePageState extends State<RiderHomePage> {
//   String riderName = "Enter Name";
//   String riderPhone = "Enter Phone";
//   String riderEmail = "Enter Email";
//   String riderAddress = "Enter Address";

//   Future<void> _updateProfile(dynamic updatedData) async {
//     setState(() {
//       riderName = updatedData['name'];
//       riderPhone = updatedData['phone'];
//       riderEmail = updatedData['email'];
//       riderAddress = updatedData['address'];
//     });
//   }

//   // Simulate a notification for new orders
//   void _simulateNewOrderNotification() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text("New Order Available!"),
//         action: SnackBarAction(
//           label: "View",
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const RiderOrdersPage()),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Rider Home'),
//         backgroundColor: Colors.orange,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications),
//             onPressed: _simulateNewOrderNotification,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'New Available Orders',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: 3,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: ListTile(
//                       leading:
//                           const Icon(Icons.shopping_bag, color: Colors.orange),
//                       title: Text('Order #${12340 + index}'),
//                       subtitle: const Text('Estimated: 8:30 - 9:15 PM'),
//                       trailing: const Icon(Icons.arrow_forward),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const RiderOrdersPage(),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: 32),
//               const Divider(),
//               const SizedBox(height: 16),
//               const Text(
//                 'Profile Riders',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               ListTile(
//                 leading: CircleAvatar(
//                   radius: 25,
//                   backgroundColor: Colors.orange.withOpacity(0.2),
//                   child:
//                       const Icon(Icons.person, size: 30, color: Colors.orange),
//                 ),
//                 title: Text(riderName),
//                 subtitle: Text(riderPhone),
//                 trailing: const Icon(Icons.arrow_forward),
//                 onTap: () async {
//                   final updatedData = await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => RiderProfilePage(
//                         initialName: riderName,
//                         initialPhone: riderPhone,
//                         initialEmail: riderEmail,
//                         initialAddress: riderAddress,
//                       ),
//                     ),
//                   );
//                   if (updatedData != null) {
//                     _updateProfile(updatedData);
//                   }
//                 },
//               ),
//               const SizedBox(height: 32),
//               const Divider(),
//               const SizedBox(height: 16),
//               const Text(
//                 'Total Earnings & History',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//               ListTile(
//                 leading: const Icon(Icons.attach_money, color: Colors.green),
//                 title: const Text('Total Earnings'),
//                 subtitle: const Text('RM 250.00'),
//                 trailing: const Icon(Icons.arrow_forward),
//                 onTap: () {
//                   // Handle earnings history navigation
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
