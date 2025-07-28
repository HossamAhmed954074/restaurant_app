import 'package:flutter/material.dart';
import 'package:resturant_app/features/cart/data/orders_data.dart';
import 'package:resturant_app/features/cart/presentation/view/widgets/build_empty_cart_custom.dart';
import 'package:resturant_app/features/cart/presentation/view/widgets/order_complete.dart';
import 'package:resturant_app/features/cart/presentation/view/widgets/order_inprogress.dart';
import 'package:resturant_app/features/cart/presentation/view/widgets/order_pending.dart';
import 'package:resturant_app/features/cart/presentation/view/widgets/tap_bar_custom.dart';

class BuildCartBody extends StatefulWidget {
  const BuildCartBody({super.key, required this.ordersData});
  final List<OrdersData> ordersData;

  @override
  State<BuildCartBody> createState() => _BuildCartBodyState();
}

class _BuildCartBodyState extends State<BuildCartBody> {
  int currentIndex = 0;
  bool isTap = false;

  late List<Widget> _tabs;

@override
  void initState() {
    super.initState();
    _tabs = [
      OrderPendingCustomWidget(ordersData: widget.ordersData),
      OrderInProgressCustomWidget(),
      OrderCompletedCustomWidget(),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TapBarCustomWidget(
                isTap: currentIndex == 0,
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
                title: 'Pending',
              ),
            ),
            Expanded(
              child: TapBarCustomWidget(
                isTap: currentIndex == 1,
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                title: 'In Progress',
              ),
            ),
            Expanded(
              child: TapBarCustomWidget(
                isTap: currentIndex == 2,
                onTap: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                title: 'Completed',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: currentIndex < _tabs.length
              ? _tabs[currentIndex]
              : const BuildEmptyCartCustom(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
