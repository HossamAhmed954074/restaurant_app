import 'package:resturant_app/core/services/auth_services.dart';
import 'package:resturant_app/features/home/data/item_data.dart';

class OrderData {
  final Itemdata itemdata;
  final double price;
  final int quantity;
  final String orderNotes;
  

  OrderData({
    required this.itemdata,
    required this.price,
    required this.quantity,
    this.orderNotes = '',
  });

  factory OrderData.fromItemdata(Itemdata itemdata, int quantity, String orderNotes) {
    return OrderData(
      itemdata: itemdata,
      price: itemdata.price * quantity,
      quantity: quantity,
      orderNotes: orderNotes,
     // orderId: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }
 
  Map<String,dynamic> toMapForFirestore() {
    return {
      'title': itemdata.title,
      'imageCategory': itemdata.imageCategory,
      'description': itemdata.description,
      'price': price,
      'quantity': quantity,
      'orderNotes': orderNotes,
      'category': itemdata.category,
      'imageFordetails': itemdata.imageFordetails,
      'rating': itemdata.rating,
      'time': itemdata.time,
      'payment':false,
      'orderStatus': 'pending',
      'orderDate': DateTime.now().toIso8601String(),
      'userId': AuthServicess().currentUser?.uid ?? '',
      'userEmail': AuthServicess().currentUser?.email ?? '',
    };
  }

 
}
