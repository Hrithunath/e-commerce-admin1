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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.blue,
              ),
              height: 40,
              child: Table(
                border: TableBorder.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                children: const [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text('Sl No')),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text('Payment Id')),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text('Product Name')),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text('Date and Time')),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text('Total Amount')),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text('Status')),
                    ),
                  ])
                ],
              ),
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
                          formattedTimestamp = DateFormat('dd-MM-yyyy HH:mm')
                              .format(timestamp.toDate());
                        } else {
                          DateTime parsedDate =
                              DateTime.parse(order['timestamp']);
                          formattedTimestamp =
                              DateFormat('dd-MM-yyyy HH:mm').format(parsedDate);
                        }
                      } catch (e) {
                        formattedTimestamp = 'Invalid Date';
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Table(
                            border: TableBorder.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            children: [
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text("${index + 1}")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(order['paymentId'] ?? 'N/A')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text(productName)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Center(child: Text(formattedTimestamp)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text(
                                          order['totalAmount'].toString())),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
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
                                ),
                              ]),
                            ],
                          ),
                        ],
                      ),
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
