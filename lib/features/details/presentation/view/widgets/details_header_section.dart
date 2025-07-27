import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:resturant_app/core/utils/styles/app_text_style.dart';

class DetailsHeaderSection extends StatelessWidget {
  const DetailsHeaderSection({super.key, required this.addToCartIconKey});

  final GlobalKey<CartIconKey> addToCartIconKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
            style: IconButton.styleFrom(
              backgroundColor: Colors.grey[100],
              padding: const EdgeInsets.all(12),
            ),
          ),
          Expanded(
            child: Text(
              'Item Details',
              style: AppTextStyle.heading2.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: AddToCartIcon(
              key: addToCartIconKey,
              icon: const Icon(Icons.shopping_cart_outlined),
              badgeOptions: const BadgeOptions(
                active: true,
                backgroundColor: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
