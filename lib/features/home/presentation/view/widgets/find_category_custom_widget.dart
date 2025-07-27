import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_app/features/home/data/category_item_data.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/categories_item.dart';

class FindByCategoryCustomWidget extends StatefulWidget {
  const FindByCategoryCustomWidget({
    super.key,
    this.onCategorySelected,
    this.isListOrGrid,
  });
  final Function(String)? onCategorySelected;
  final Function(bool)? isListOrGrid;

  @override
  State<FindByCategoryCustomWidget> createState() =>
      _FindByCategoryCustomWidgetState();
}

class _FindByCategoryCustomWidgetState
    extends State<FindByCategoryCustomWidget> {
  int? selectedIndex;
  bool isListOrGrid = false;
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Find by Category',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isListOrGrid = !isListOrGrid;
                      widget.isListOrGrid?.call(isListOrGrid);
                    });
                  },
                  icon: isListOrGrid ? Icon(Icons.grid_3x3) : Icon(Icons.list),
                ),
              ],
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
                      widget.onCategorySelected?.call(
                        categoryItems[index].title,
                      );
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

