import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_app/features/home/data/category_item_data.dart';

class FindByCategoryCustomWidget extends StatefulWidget {
  const FindByCategoryCustomWidget({super.key, this.onCategorySelected});
  final Function(String)? onCategorySelected;

  @override
  State<FindByCategoryCustomWidget> createState() => _FindByCategoryCustomWidgetState();
}

class _FindByCategoryCustomWidgetState extends State<FindByCategoryCustomWidget> {
  int? selectedIndex ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Find by Category',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryItems.length,
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      widget.onCategorySelected?.call(categoryItems[index].title);
                    });
                  },
                  child: CategoryItem(
                    categoryItemData: categoryItems[index],
                    onTap: selectedIndex == index,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.categoryItemData, required this.onTap,});
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
                backgroundImage: AssetImage(categoryItemData.imageCategory,),
              ),
            ),
            const SizedBox(height: 5),
            Text(categoryItemData.title,
            style: GoogleFonts.poppins(
              fontSize: 14,
            ),
            ),
          ],
        ),
      ),
    );
  }
}