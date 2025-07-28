import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resturant_app/features/cart/data/orders_data.dart';
import 'package:resturant_app/features/details/data/order_data.dart';
import 'package:resturant_app/features/home/data/item_data.dart';

class OrderServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Method to create an order
  Future<void> createOrder(
    Itemdata itemData,
    int quantity,
    String orderNotes,
  ) async {
    final orderData = OrderData.fromItemdata(itemData, quantity, orderNotes);
    await saveOrderToDatabase(orderData);
  }

  // Placeholder for saving order data to the database
  Future<void> saveOrderToDatabase(OrderData orderData) async {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    // Assuming orderId is generated in OrderData
    var orderId = DateTime.now().millisecondsSinceEpoch.toString();
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('orders')
        .doc(orderId)
        .set({
      ...orderData.toMapForFirestore(),
      'orderId': orderId, // Ensure orderId is included in the document
        });
  }

  // Method to fetch orders for the current user
  Future<List<OrdersData>> fetchOrders() async {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    final snapshot = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('orders')
        .orderBy('orderDate', descending: true)
        .get();
    return snapshot.docs.map((doc) {
      if(doc['payment'] == false){
        return OrdersData.fromFirestore(doc);
      }
      return null;
    }).whereType<OrdersData>().toList();
  }

  // method to remove the order for current user
  deleteOrder({required String orderId}) async {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('orders')
        .doc(orderId)
        .delete();
  }
}
