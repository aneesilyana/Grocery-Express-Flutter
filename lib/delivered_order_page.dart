import 'package:flutter/material.dart';

class DeliveredOrderPage extends StatelessWidget {
  const DeliveredOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivered Order'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: const Center(
                child: Text('Map View Placeholder'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order ID #12340',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Estimated 8:30 - 9:15 PM'),
                const Divider(),
                const Text('Order Details: Kiwi'),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('No 24, Jalan Makmur, Pekan'),
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
                      // Handle navigation
                    },
                    child: const Text('Start Navigation'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
