import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_app/features/home/data/category_item_data.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.categoryItemData,
    required this.onTap,
  });
  final CategoryItemData categoryItemData;
  final bool onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: onTap ? Colors.orange : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage(categoryItemData.imageCategory),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              categoryItemData.title,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
