import 'package:flutter/material.dart';
// import 'delivery_page.dart'; // Import the Delivery Page

class RiderOrdersPage extends StatelessWidget {
  const RiderOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Location',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 8),
                Text('No 22, Kg Makmur, Pekan Pahang'),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery Earnings'),
                Text('RM 24.00'),
              ],
            ),
            const Divider(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Est. Earnings',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'RM 30.00',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     // builder: (context) => const DeliveryPage(),
                  //   ),
                  // );
                },
                child: const Text('Accept Delivery'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
