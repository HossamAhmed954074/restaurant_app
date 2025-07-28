import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app/core/utils/widgets/show_circle_indecator.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_sucess.dart';
import 'package:resturant_app/features/cart/data/orders_data.dart';
import 'package:resturant_app/features/cart/presentation/view_model/cubit/cart_orders_cubit.dart';

class OrderPendingCustomWidget extends StatelessWidget {
  const OrderPendingCustomWidget({super.key, required this.ordersData});
  final List<OrdersData> ordersData;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ordersData.length,
      itemBuilder: (context, index) {
        return OrderItemCustomWidget(
          ordersData: ordersData[index],
          doNothing: (context) => dothing(context, index),
          onDismissed: () {
            dothing(context, index);
          },
        );
      },
    );
  }

  void dothing(BuildContext context, int index) {
    BlocProvider.of<CartOrdersCubit>(
      context,
    ).deleteOrder(ordersData[index].orderId);
    showSnakBarSuccess(
      context,
      'Order with ${ordersData[index].orderTitle} deleted successfully',
    );
  }
}

class OrderItemCustomWidget extends StatelessWidget {
  const OrderItemCustomWidget({
    super.key,
    required this.doNothing,
    required this.ordersData,
    required this.onDismissed,
  });

  final SlidableActionCallback doNothing;
  final OrdersData ordersData;
  final Function() onDismissed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Slidable(
        key: ValueKey(ordersData.orderId),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: onDismissed),
          extentRatio: 0.25,

          children: [
            SlidableAction(
              onPressed: doNothing,
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    'https://drive.google.com/uc?export=view&id=${ordersData.orderImageForDetails}',
                fit: BoxFit.contain,
                width: 100,
                height: 120,
                placeholder: (context, url) => Container(
                  color: Colors.grey[100],
                  child: Center(
                    child: circleIndeactorCustom(context, Colors.redAccent),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported,
                        size: 48,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Image not available',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ordersData.orderTitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ordersData.orderNotes,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Quantity: ${ordersData.orderQuantity}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$${ordersData.orderTotalPrice}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            // Handle button press
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Colors.redAccent,
                          ),
                          child: const Text(
                            'Pay Now',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
