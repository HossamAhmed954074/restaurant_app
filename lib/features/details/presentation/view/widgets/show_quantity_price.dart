
import 'package:flutter/material.dart';
import 'package:resturant_app/core/utils/styles/app_text_style.dart';

/// Improved quantity price display widget
class ShowQuantityPrice extends StatelessWidget {
  const ShowQuantityPrice({
    super.key,
    required this.quantity,
    required this.price,
  });

  final int quantity;
  final double price;

  @override
  Widget build(BuildContext context) {
    final totalPrice = price * quantity;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),

      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.redAccent, Colors.redAccent[700]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Total',
            style: AppTextStyle.caption.copyWith(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '\$${totalPrice.toStringAsFixed(2)}',
            style: AppTextStyle.heading2.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
