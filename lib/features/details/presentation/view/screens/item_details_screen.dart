import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_app/core/router/app_router.dart';
import 'package:resturant_app/features/home/data/item_data.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key, required this.itemData});
  final Itemdata itemData;
  @override
  Widget build(BuildContext context) {
    log('Item Details Screen: ${itemData.title}', name: 'ItemDetailsScreen');
    return Scaffold(
      appBar: AppBar(
        title: Text(itemData.title),
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => GoRouter.of(context).pushReplacement(
        //     AppRouter.kBottomNavBarScreen,
        //   ),
        // ),
      ),
      body: Center(child: Text(itemData.title)));
  }
}