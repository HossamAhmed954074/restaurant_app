import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app/core/utils/widgets/show_circle_indecator.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_faluire.dart';
import 'package:resturant_app/features/home/data/item_data.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/items_grid_body.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/items_list_body.dart';
import 'package:resturant_app/features/home/presentation/view_model/cubit/home_cubit.dart';

class MenuItemsByCategory extends StatefulWidget {
  const MenuItemsByCategory({super.key, required this.isListOrGrid});
  final bool isListOrGrid;

  @override
  State<MenuItemsByCategory> createState() => _MenuItemsByCategoryState();
}

class _MenuItemsByCategoryState extends State<MenuItemsByCategory> {
  List<Itemdata> categoryItemData = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          showSnakBarFaluire(context, state.message);
        }
        if (state is HomeLoaded) {
          categoryItemData = state.menuData.toList();
          if (categoryItemData.isEmpty) {
            showSnakBarFaluire(context, 'No items found in this category');
          }
        }
        if (state is HomeLoading) {
          categoryItemData = [];
        }
      },
      builder: (context, state) {
        if (categoryItemData.isEmpty && state is! HomeLoading) {
          return const Center(child: Text('No items found'));
        }
        return Stack(
          children: [
            if (categoryItemData.isNotEmpty)
              if (widget.isListOrGrid)
                ItemMenuListViewBody(itemData: categoryItemData),
            if (!widget.isListOrGrid)
              ItemsMenuGridViewBody(categoryItemData: categoryItemData),

            if (state is HomeLoading)
              Center(child: circleIndeactorCustom(context, Colors.orange)),
          ],
        );
      },
    );
  }
}




