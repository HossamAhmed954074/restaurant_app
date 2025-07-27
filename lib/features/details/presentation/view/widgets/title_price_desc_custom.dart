import 'package:flutter/material.dart';
import 'package:resturant_app/core/utils/styles/app_text_style.dart';
import 'package:resturant_app/features/home/data/item_data.dart';

/// Improved item title, price and description widget
class ItemTitleAndPriceAndDescription extends StatelessWidget {
  const ItemTitleAndPriceAndDescription({super.key, required this.itemData});

  final Itemdata itemData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title
        Text(
          itemData.title,
          style: AppTextStyle.heading1.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),

        // Price
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green[200]!),
          ),
          child: Text(
            '\$${itemData.price.toStringAsFixed(2)}',
            style: AppTextStyle.heading2.copyWith(
              fontSize: 20,
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Description
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            itemData.description,
            style: const TextStyle(fontSize: 16, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
