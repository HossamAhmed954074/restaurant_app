
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/find_category_custom_widget.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/menu_header_custom_widget.dart';
import 'package:resturant_app/features/home/presentation/view/widgets/menu_items.dart';
import 'package:resturant_app/features/home/presentation/view_model/cubit/home_cubit.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getShuffledItems(),
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
  bool isListorGrid = false;
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
          isListOrGrid: (p0) {
            setState(() {
              isListorGrid =p0;
            });
          },
        ),
        const SizedBox(height: 10),
        Expanded(child: MenuItemsByCategory(isListOrGrid: isListorGrid,)),
      ],
    );
  }
}




