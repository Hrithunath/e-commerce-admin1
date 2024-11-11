import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/view_model/provider/view_models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  final String uid;

  OrderDetails({super.key, required this.uid});

  final List<String> statusOptions = ['Pending', 'Shipped', 'Delivered'];

  @override
  Widget build(BuildContext context) {
    // Fetch orders initially
    Provider.of<Orders>(context, listen: false).fetchOrders(uid);

    return Scaffold(
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            child: Table(
              children: const [
                TableRow(children: [
                  Text('Sl No'),
                  Text('Payment Id'),
                  Text('Product Name'),
                  Text('Date and Time'),
                  Text('Total Amount'),
                  Text('Status'),
                ])
              ],
            ),
          ),
          Consumer<Orders>(
            builder: (context, ordersProvider, child) {
              var orders = ordersProvider.orders;

              if (orders.isEmpty) {
                return const Center(child: Text('No orders found.'));
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    var order = orders[index];
                    List cartItems = order['cartItems'] ?? [];
                    String productName = cartItems.isNotEmpty
                        ? cartItems[0]['productName'] ?? 'No Name'
                        : 'No Cart Items';

                    String formattedTimestamp = 'N/A';
                    if (order['timestamp'] != null) {
                      try {
                        if (order['timestamp'] is Timestamp) {
                          Timestamp timestamp = order['timestamp'];
                          formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm')
                              .format(timestamp.toDate());
                        } else {
                          DateTime parsedDate =
                              DateTime.parse(order['timestamp']);
                          formattedTimestamp =
                              DateFormat('yyyy-MM-dd HH:mm').format(parsedDate);
                        }
                      } catch (e) {
                        formattedTimestamp = 'Invalid Date';
                      }
                    }

                    return Column(
                      children: [
                        Table(
                          children: [
                            TableRow(children: [
                              Text("${index + 1}"),
                              Text(order['paymentId'] ?? 'N/A'),
                              Text(productName),
                              Text(formattedTimestamp),
                              Text(order['totalAmount'].toString()),
                              DropdownButton(
                                value: order['status'],
                                items: statusOptions.map((String status) {
                                  print(order['status']);
                                  return DropdownMenuItem(
                                    value: status,
                                    child: Text(status),
                                  );
                                }).toList(),
                                onChanged: (newStatus) {
                                  if (newStatus != null) {
                                    ordersProvider.updateOrder(
                                      uid,
                                      order['orderId'],
                                      {'status': newStatus},
                                    );
                                  }
                                },
                              ),
                            ]),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
