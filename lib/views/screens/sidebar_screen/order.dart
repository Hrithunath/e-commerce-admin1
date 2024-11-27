import 'package:e_commerce_admin/view_model/provider/view_models/order.dart';
import 'package:e_commerce_admin/views/screens/orderDetails.dart';
import 'package:e_commerce_admin/views/widgets/button.dart';
import 'package:e_commerce_admin/views/widgets/text.dart';
import 'package:flutter/material.dart';

class OrderList extends StatelessWidget {
  final Orders orders = Orders();

  OrderList({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.blue,
            ),
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                children: const [
                  TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: TextCustom(text: 'Sl No')),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: TextCustom(text: 'User Name')),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: TextCustom(text: 'Email')),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: TextCustom(text: 'Order Details')),
                    ),
                  ]),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: orders.fetchUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  var users = snapshot.data!;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      var user = users[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Table(
                              border: TableBorder.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              children: [
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: TextCustom(
                                            text: (index + 1).toString())),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: TextCustom(
                                            text: user['name'] ?? 'No Name')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: TextCustom(
                                            text: user['email'] ?? 'No email')),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: Size.zero,
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap),
                                        onPressed: () {
                                          String uid = user['uid'].toString();
                                          print(uid);
                                          if (user['name'] != null &&
                                              user['email'] != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderDetails(uid: uid),
                                              ),
                                            );
                                            print(
                                                "User tapped: ${user['name']}");
                                          } else {
                                            print(
                                                "User details are incomplete.");
                                          }
                                        },
                                        child: const Text(
                                          'OrderDetails',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ),
                                ])
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No users found.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
