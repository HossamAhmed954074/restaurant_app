import 'package:flutter/material.dart';
import 'package:resturant_app/features/home/data/item_data.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/item_custom_list.dart';

class ItemMenuListViewBody extends StatelessWidget {
  const ItemMenuListViewBody({super.key, required this.itemData});
  final List<Itemdata> itemData;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      physics: const BouncingScrollPhysics(),
      itemCount: itemData.length,
      itemBuilder: (context, index) {
        return ItemCustomWidgetListView(itemdata: itemData[index]);
      },
    );
  }
}