
import 'package:flutter/material.dart';
import 'package:resturant_app/features/home/data/item_data.dart';

class RatingAndTimeDetails extends StatelessWidget {
  const RatingAndTimeDetails({super.key, required this.itemData});

  final Itemdata itemData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildInfoItem(
            icon: Icons.star,
            iconColor: Colors.orange,
            label: 'Rating',
            value: itemData.rating,
            color: Colors.orange[700]!,
          ),
          Container(height: 40, width: 1, color: Colors.grey[300]),
          _buildInfoItem(
            icon: Icons.timer,
            iconColor: Colors.blue,
            label: 'Time',
            value: itemData.time,
            color: Colors.blue[700]!,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
