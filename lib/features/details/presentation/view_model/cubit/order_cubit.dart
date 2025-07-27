import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:resturant_app/core/services/order_services.dart';
import 'package:resturant_app/features/home/data/item_data.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  final OrderServices orderServices = OrderServices();

  Future<void> createOrder(Itemdata itemData, int quantity, String orderNotes) async {
    emit(OrderLoading());
    try {
      await orderServices.createOrder(itemData, quantity, orderNotes);
      emit(OrderSuccess());
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
