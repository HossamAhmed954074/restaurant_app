part of 'cart_orders_cubit.dart';

@immutable
sealed class CartOrdersState {}

final class CartOrdersInitial extends CartOrdersState {}
final class CartOrdersLoading extends CartOrdersState {}
final class CartOrdersLoaded extends CartOrdersState {
  final List<OrdersData> ordersData;

  CartOrdersLoaded(this.ordersData);}
final class CartOrdersError extends CartOrdersState {
  final String message;

  CartOrdersError(this.message);
}