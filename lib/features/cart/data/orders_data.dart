import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersData {
  final String orderCategory;
  final String orderDescription;
  final String orderImageForDetails;
  final DateTime orderDate;
  final String orderId;
  final String orderStatus;
  final double orderTotalPrice;
  final bool isOrderPaymentDone;
  final int orderQuantity;
  final String orderTitle;
  final String orderTime;
  final String orderUserEmail;
  final String orderUserID;
  final String orderNotes;


  OrdersData( {
    required this.orderCategory,
    required this.orderDescription,
    required this.orderImageForDetails,
    required this.orderDate,
    required this.orderId,
    required this.orderStatus,
    required this.orderTotalPrice,
    required this.isOrderPaymentDone,
    required this.orderQuantity,
    required this.orderTitle,
    required this.orderTime,
    required this.orderUserEmail,
    required this.orderUserID,
    required this.orderNotes,
  });

  factory OrdersData.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrdersData(
      orderCategory: data['category'] ?? '',
      orderDescription: data['description'] ?? '',
      orderImageForDetails: data['imageFordetails'] ?? '',
      orderDate: DateTime.parse(data['orderDate'] ?? ''),
      orderId: data['orderId'] ?? '',
      orderStatus: data['orderStatus'] ?? '',
      orderTotalPrice: data['price'] ?? 0.0,
      isOrderPaymentDone: data['payment'] ?? false,
      orderQuantity: data['quantity'] ?? 0,
      orderTitle: data['title'] ?? '',
      orderTime: data['time'] ?? '',
      orderUserEmail: data['userEmail'] ?? '',
      orderUserID: data['userId'] ?? '',
      orderNotes: data['orderNotes'] ?? '',
    );
  }
}