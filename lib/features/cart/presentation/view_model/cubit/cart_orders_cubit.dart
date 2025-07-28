import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:resturant_app/core/services/order_services.dart';
import 'package:resturant_app/features/cart/data/orders_data.dart';

part 'cart_orders_state.dart';

class CartOrdersCubit extends Cubit<CartOrdersState> {
  CartOrdersCubit() : super(CartOrdersInitial());

  final OrderServices _orderServices = OrderServices();

  Future<void> fetchOrders() async {
    emit(CartOrdersLoading());
    try {
      final List<OrdersData> orders = await _orderServices.fetchOrders();
      if (orders.isEmpty) {
        emit(CartOrdersError("No orders found"));
        return;
      }
   
      emit(CartOrdersLoaded(orders));
    } catch (e) {
      emit(CartOrdersError(e.toString()));
    }
  }

  deleteOrder(String orderId) async {
    try {
      log("Deleting order with ID: $orderId");
      await _orderServices.deleteOrder(orderId: orderId);
      log("Order with ID $orderId deleted successfully");
    // emit(OrderDeleted(orderId));
      // Optionally, you can refetch orders after deletion
      await fetchOrders();
    } catch (e) {
      emit(CartOrdersError(e.toString()));
    }
  }
}
