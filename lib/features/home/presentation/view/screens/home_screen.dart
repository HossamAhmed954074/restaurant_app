import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_app/core/utils/styles/app_text_style.dart';
import 'package:resturant_app/core/utils/widgets/show_circle_indecator.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_faluire.dart';

import 'package:resturant_app/features/home/data/item_data.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/find_category_custom_widget.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/menu_header_custom_widget.dart';
import 'package:resturant_app/features/home/presentation/view_model/cubit/home_cubit.dart';

import '../../../../../generated/assets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllMenuItems(id: 'Pizza'),
      child: MenuBody(),
    );
  }
}

class MenuBody extends StatefulWidget {
  const MenuBody({super.key});

  @override
  State<MenuBody> createState() => _MenuBodyState();
}

class _MenuBodyState extends State<MenuBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuHeaderCustomWidget(),
        const SizedBox(height: 10),
        FindByCategoryCustomWidget(
          onCategorySelected: (p0) {
            setState(() {
              BlocProvider.of<HomeCubit>(context).getAllMenuItems(id: p0);
            });
          },
        ),
        const SizedBox(height: 10),
        Expanded(child: MenuItemsByCategory()),
      ],
    );
  }
}

class MenuItemsByCategory extends StatefulWidget {
  const MenuItemsByCategory({super.key});

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
              GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: categoryItemData.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.65555,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return ItemCustomWidget(itemData: categoryItemData[index]);
                },
              ),
            if (state is HomeLoading)
              Center(child: circleIndeactorCustom(context, Colors.orange)),
          ],
        );
      },
    );
  }
}

class ItemCustomWidget extends StatelessWidget {
  const ItemCustomWidget({super.key, required this.itemData});
  final Itemdata itemData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: CachedNetworkImage(
              imageUrl: itemData.imageCategory,
              imageBuilder: (context, imageProvider) => Container(
                height: 150,
                decoration: BoxDecoration(
                 // borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              placeholder: (context, url) => Center(
                child: circleIndeactorCustom(context, Colors.redAccent)
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            itemData.title,
            style: AppTextStyle.menuItemTitle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 16),
              const SizedBox(width: 5),
              Text(
                itemData.rating.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Spacer(),
              Icon(Icons.timer, color: Colors.redAccent, size: 16),
              const SizedBox(width: 5),
              Text(
                itemData.time,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${itemData.price}',
                style: AppTextStyle.menuItemPrice.copyWith(color: Colors.green),
              ),
              SizedBox(
                width: 35,
                height: 35,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
