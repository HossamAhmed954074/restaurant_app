import 'dart:developer';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_faluire.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_sucess.dart';
import 'package:resturant_app/features/details/presentation/view/widgets/add_cart_custom_button.dart';
import 'package:resturant_app/features/details/presentation/view/widgets/add_items_notes_for_order.dart';
import 'package:resturant_app/features/details/presentation/view/widgets/details_header_section.dart';
import 'package:resturant_app/features/details/presentation/view/widgets/hero_image_custom_widget.dart';
import 'package:resturant_app/features/details/presentation/view/widgets/quantity_selector_custom.dart';
import 'package:resturant_app/features/details/presentation/view/widgets/rating_time_details.dart';
import 'package:resturant_app/features/details/presentation/view/widgets/show_quantity_price.dart';
import 'package:resturant_app/features/details/presentation/view/widgets/title_price_desc_custom.dart';
import 'package:resturant_app/features/details/presentation/view_model/cubit/order_cubit.dart';
import 'package:resturant_app/features/home/data/item_data.dart';

/// Screen that displays detailed information about a menu item
/// Allows users to view item details, adjust quantity, add notes, and add to cart
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

/// Main body widget for the item details screen
class ItemDetailsBody extends StatefulWidget {
  const ItemDetailsBody({super.key, required this.itemData});

  final Itemdata itemData;

  @override
  State<ItemDetailsBody> createState() => _ItemDetailsBodyState();
}

class _ItemDetailsBodyState extends State<ItemDetailsBody> {
  // State variables
  int _quantity = 1;
  int _cartItemCount = 0;
  bool _isLoading = false;

  // Controllers and keys
  late final TextEditingController _notesController;
  late final GlobalKey<CartIconKey> _addToCartIconKey;
  late final GlobalKey _widgetKey;

  // Animation function
  Function(GlobalKey)? _runAddToCartAnimation;

  // Flag to track if image preloading has been done
  bool _hasPreloadedImage = false;

  // Constants
  static const int _minQuantity = 1;
  static const int _maxQuantity = 99;
  static const Duration _animationDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Preload image only once after dependencies are available
    if (!_hasPreloadedImage) {
      _preloadImage();
      _hasPreloadedImage = true;
    }
  }

  /// Initialize controllers and keys
  void _initializeControllers() {
    _notesController = TextEditingController();
    _addToCartIconKey = GlobalKey<CartIconKey>();
    _widgetKey = GlobalKey();
    log(
      'ItemDetailsScreen initialized for item: ${widget.itemData.title}',
      name: 'ItemDetailsScreen',
    );
  }

  /// Preload the detail image for better performance
  void _preloadImage() {
    if (widget.itemData.imageFordetails.isNotEmpty) {
      precacheImage(
        CachedNetworkImageProvider(
          'https://drive.google.com/uc?export=view&id=${widget.itemData.imageFordetails}',
        ),
        context,
      ).catchError((error) {
        log('Error preloading image: $error', name: 'ItemDetailsScreen');
      });
    }
  }

  @override
  void dispose() {
    _cleanupResources();
    super.dispose();
  }

  /// Clean up resources to prevent memory leaks
  void _cleanupResources() {
    _notesController.dispose();
    log('ItemDetailsScreen disposed', name: 'ItemDetailsScreen');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: _handleOrderStateChange,
      child: AddToCartAnimation(
        cartKey: _addToCartIconKey,
        dragAnimation: const DragToCartAnimationOptions(
          duration: _animationDuration,
          curve: Curves.easeInOut,
        ),
        jumpAnimation: const JumpAnimationOptions(
          duration: _animationDuration,
          curve: Curves.easeInOut,
        ),
        createAddToCartAnimation: (function) {
          _runAddToCartAnimation = function;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              DetailsHeaderSection(addToCartIconKey: _addToCartIconKey),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeroImageCustomWidget(
                        itemData: widget.itemData,
                        widgetKey: _widgetKey,
                      ),
                      const SizedBox(height: 16),
                      ItemTitleAndPriceAndDescription(
                        itemData: widget.itemData,
                      ),
                      const SizedBox(height: 16),
                      RatingAndTimeDetails(itemData: widget.itemData),
                      const SizedBox(height: 20),
                      QuantitySelector(
                        quantity: _quantity,
                        minQuantity: _minQuantity,
                        maxQuantity: _maxQuantity,
                        onQuantityChanged: _updateQuantity,
                        isEnabled: !_isLoading,
                      ),
                      const SizedBox(height: 16),
                      AddItemNotesForOrder(notesController: _notesController),
                      const SizedBox(height: 24),
                      _buildActionRow(),
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

  /// Handles state changes from the OrderCubit
  void _handleOrderStateChange(BuildContext context, OrderState state) {
    switch (state) {
      case OrderSuccess():
        _handleOrderSuccess();
        break;
      case OrderError():
        _handleOrderError(context, state.message);
        break;
      case OrderLoading():
        _setLoading(true);
        break;
      default:
        _setLoading(false);
    }
  }

  /// Handles successful order creation
  void _handleOrderSuccess() {
    _setLoading(false);
    _playAddToCartAnimation();
    _showSuccessMessage();
  }

  /// Handles order creation errors
  void _handleOrderError(BuildContext context, String message) {
    _setLoading(false);
    showSnakBarFaluire(context, message);
    log('Order creation failed: $message', name: 'ItemDetailsScreen');
  }

  /// Updates loading state
  void _setLoading(bool loading) {
    if (mounted && _isLoading != loading) {
      setState(() {
        _isLoading = loading;
      });
    }
  }

  /// Updates quantity with validation
  void _updateQuantity(int newQuantity) {
    if (newQuantity >= _minQuantity &&
        newQuantity <= _maxQuantity &&
        newQuantity != _quantity) {
      setState(() {
        _quantity = newQuantity;
      });
      log('Quantity updated to: $newQuantity', name: 'ItemDetailsScreen');
    }
  }

  /// Builds the action row with price display and add to cart button
  Widget _buildActionRow() {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ShowQuantityPrice(
            quantity: _quantity,
            price: widget.itemData.price,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AddToCartCustomButton(
            onPressed: _addToCart,
            isLoading: _isLoading,
          ),
        ),
      ],
    );
  }

  /// Plays the add to cart animation
  Future<void> _playAddToCartAnimation() async {
    try {
      if (_runAddToCartAnimation != null) {
        await _runAddToCartAnimation!(_widgetKey);
      }

      final cartIconState = _addToCartIconKey.currentState;
      if (cartIconState != null) {
        _cartItemCount += _quantity;
        await cartIconState.runCartAnimation(_cartItemCount.toString());
      }
    } catch (e) {
      log('Error playing add to cart animation: $e', name: 'ItemDetailsScreen');
    }
  }

  /// Shows success message
  void _showSuccessMessage() {
    if (mounted) {
      showSnakBarSuccess(context, 'Item added to cart successfully');
    }
  }

  /// Handles add to cart action
  void _addToCart() {
    if (_isLoading) return;

    try {
      final orderCubit = context.read<OrderCubit>();
      orderCubit.createOrder(
        widget.itemData,
        _quantity,
        _notesController.text.trim(),
      );
      log(
        'Adding ${widget.itemData.title} to cart (quantity: $_quantity)',
        name: 'ItemDetailsScreen',
      );
    } catch (e) {
      log('Error adding item to cart: $e', name: 'ItemDetailsScreen');
      if (mounted) {
        showSnakBarFaluire(context, 'Failed to add item to cart');
      }
    }
  }
}
