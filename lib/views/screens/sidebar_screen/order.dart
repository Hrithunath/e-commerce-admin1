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
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: orders.fetchUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          var users = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(15),
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.green,
                        ),
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Table(
                            children: const [
                              TableRow(children: [
                                TextCustom(text: 'Sl No'),
                                TextCustom(text: 'User Name'),
                                TextCustom(text: 'Email'),
                              ]),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Table(
                          children: [
                            TableRow(children: [
                              TextCustom(text: (index + 1).toString()),
                              TextCustom(text: user['name'] ?? 'No Name'),
                              TextCustom(text: user['email'] ?? 'No email'),
                              SizedBox(
                                height: 30,
                                width: 5,
                                child: ButtonCustomized(
                                    color: Colors.amber,
                                    text: 'OrderDetails',
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
                                        print("User tapped: ${user['name']}");
                                      } else {
                                        print("User details are incomplete.");
                                      }
                                    }),
                              ),
                            ])
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text('No users found.'));
        }
      },
    );
  }
}
