import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resturant_app/features/details/data/order_data.dart';
import 'package:resturant_app/features/home/data/item_data.dart';

class OrderServices {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Method to create an order
  Future<void> createOrder(Itemdata itemData, int quantity, String orderNotes) async {
    final orderData = OrderData.fromItemdata(itemData, quantity, orderNotes);
    await saveOrderToDatabase(orderData);
  }

  // Placeholder for saving order data to the database
  Future<void> saveOrderToDatabase(OrderData orderData) async {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    await firestore.collection('users').doc(user.uid).collection('orders').add(orderData.toMapForFirestore());
  }
}