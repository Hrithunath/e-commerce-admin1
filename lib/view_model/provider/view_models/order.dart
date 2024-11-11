import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Orders extends ChangeNotifier {
  List<Map<String, dynamic>> orders = [];

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      if (snapshot.docs.isEmpty) {
        print("No users found");
        return [];
      }

      List<Map<String, dynamic>> fetchedUsers = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      print("Fetched users: $fetchedUsers");

      return fetchedUsers;
    } catch (e) {
      print("Error fetching orders: $e");
      throw Exception("Error fetching orders: $e");
    }
  }

  Future<void> fetchOrders(String uid) async {
    try {
      print("Fetching orders for UID: $uid");
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('orders')
          .get();

      orders = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      print("Fetched orders: $orders");
      notifyListeners();
    } catch (e) {
      print("Error fetching orders: $e");
      throw Exception("Error fetching orders: $e");
    }
  }

  Future<void> updateOrder(
    String uid,
    String orderId,
    Map<String, dynamic> updatedData,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('orders')
          .doc(orderId)
          .update(updatedData);

      // Fetch updated orders and notify listeners to refresh UI
      await fetchOrders(uid);
      notifyListeners();
    } catch (e) {
      print("Failed to update order: $e");
    }
  }

  Future<Map<String, int>> fetchAllOderCount() async {
    Map<String, int> statusCounts = {
      'Pending': 0,
      'Shipped': 0,
      'Delivered': 0
    };
    try {
      QuerySnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      for (QueryDocumentSnapshot user in userSnapshot.docs) {
        QuerySnapshot usersOrders = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.id)
            .collection('orders')
            .get();

        for (var order in usersOrders.docs) {
          String status =
              (order.data() as Map<String, dynamic>)['status'] ?? '';
          print('Order status: $status');
          if (statusCounts.containsKey(status)) {
            statusCounts[status] = statusCounts[status]! + 1;
          }
          print(
              'Status: $status, statusCounts contains: ${statusCounts.containsKey(status)}');
        }
      }
    } catch (e) {
      print('  print("Error fetching order counts: $e");');
    }
    return statusCounts;
  }
}
