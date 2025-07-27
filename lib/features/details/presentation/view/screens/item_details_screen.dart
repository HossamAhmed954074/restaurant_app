import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app/core/utils/styles/app_text_style.dart';
import 'package:resturant_app/core/utils/widgets/show_circle_indecator.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_faluire.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_sucess.dart';
import 'package:resturant_app/features/details/presentation/view_model/cubit/order_cubit.dart';

import 'package:resturant_app/features/home/data/item_data.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key, required this.itemData});
  final Itemdata itemData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ItemDetailsBody(itemData: itemData)),
    );
  }
}

class ItemDetailsBody extends StatefulWidget {
  const ItemDetailsBody({super.key, required this.itemData});
  final Itemdata itemData;

  @override
  State<ItemDetailsBody> createState() => _ItemDetailsBodyState();
}

class _ItemDetailsBodyState extends State<ItemDetailsBody> {
  double allPrice = 0.0;
  int quantity = 1;
  int _cartItemCount = 0;
  final TextEditingController notesController = TextEditingController();

  final GlobalKey<CartIconKey> addToCartIconKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  final GlobalKey widgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    CachedNetworkImage(
      imageUrl: widget.itemData.imageFordetails,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    notesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is OrderSuccess) {
          listClick(widgetKey);
          showSnakBarSuccess(context, 'Item added to cart successfully');
        }
        if (state is OrderError) {
          // Show an error message
          showSnakBarFaluire(context, state.message);
        }
      },
      child: AddToCartAnimation(
        cartKey: addToCartIconKey,
        dragAnimation: DragToCartAnimationOptions(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        ),
        jumpAnimation: JumpAnimationOptions(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        ),
        createAddToCartAnimation: (p0) {
          runAddToCartAnimation = p0;
        },

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Menu Item Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  AddToCartIcon(
                    key: addToCartIconKey,
                    icon: Icon(Icons.add_shopping_cart),
                    badgeOptions: BadgeOptions(
                      active: true,
                      backgroundColor: Colors.redAccent,
                    ),
                  ),
                  // IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
                ],
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // header section
                      Hero(
                        tag: widget.itemData.imageFordetails,
                        child: Container(
                          key: widgetKey,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.4,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: widget.itemData.imageFordetails,
                            imageBuilder: (context, imageProvider) => Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Center(
                              child: circleIndeactorCustom(
                                context,
                                Colors.redAccent,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          widget.itemData.title,
                          style: AppTextStyle.heading1.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Price: \$${widget.itemData.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        widget.itemData.description,
                        style: AppTextStyle.caption.copyWith(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Rating: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.orange,
                                ),
                              ),
                              Icon(Icons.star, color: Colors.orange, size: 16),
                              const SizedBox(width: 5),
                              Text(widget.itemData.rating),
                            ],
                          ),

                          Row(
                            children: [
                              Text(
                                'Time: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                              Icon(
                                Icons.timer,
                                color: Colors.redAccent,
                                size: 16,
                              ),
                              const SizedBox(width: 5),
                              Text(widget.itemData.time),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  if (quantity > 1) {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                              ),
                              Text('$quantity', style: TextStyle(fontSize: 20)),
                              IconButton(
                                icon: Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  // Add your increment logic here
                                  setState(() {
                                    quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // add notes for custom order
                      TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Add Notes (Optional)',
                          labelStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          hintText: 'Special instructions for your order',
                        ),
                        style: TextStyle(fontSize: 16),
                        controller: notesController,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              '\$ ${(widget.itemData.price * quantity).toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {
                              allPrice = widget.itemData.price * quantity;
                              pushOrderToDatabase();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.5,
                                50,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              textStyle: TextStyle(fontSize: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void listClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await addToCartIconKey.currentState!.runCartAnimation(
      (_cartItemCount += quantity).toString(),
    );
  }

  pushOrderToDatabase() {
    final orderCubit = context.read<OrderCubit>();
    orderCubit.createOrder(widget.itemData, quantity, notesController.text);
  }
}
