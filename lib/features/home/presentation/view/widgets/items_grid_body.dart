import 'package:flutter/material.dart';
import 'package:resturant_app/features/home/data/item_data.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/item_custom_grid.dart';

class ItemsMenuGridViewBody extends StatelessWidget {
  const ItemsMenuGridViewBody({
    super.key,
    required this.categoryItemData,
  });

  final List<Itemdata> categoryItemData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: categoryItemData.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.65555,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return ItemCustomWidgetGridView(itemData: categoryItemData[index]);
      },
    );
  }
}
