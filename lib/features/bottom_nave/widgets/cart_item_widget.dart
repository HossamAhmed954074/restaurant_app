import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItemModel {
  const CartItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    this.description,
    this.maxQuantity = 10,
  });

  final String id;
  final String name;
  final String image;
  final double price;
  final int quantity;
  final String? description;
  final int maxQuantity;

  CartItemModel copyWith({
    String? id,
    String? name,
    String? image,
    double? price,
    int? quantity,
    String? description,
    int? maxQuantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      maxQuantity: maxQuantity ?? this.maxQuantity,
    );
  }

  double get totalPrice => price * quantity;
}

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  final CartItemModel item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _handleQuantityChange(int delta) {
    final newQuantity = widget.item.quantity + delta;
    if (newQuantity >= 1 && newQuantity <= widget.item.maxQuantity) {
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
      widget.onQuantityChanged(newQuantity);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Item image
                  _buildItemImage(),

                  const SizedBox(width: 16),

                  // Item details
                  Expanded(child: _buildItemDetails()),

                  const SizedBox(width: 16),

                  // Quantity controls
                  _buildQuantityControls(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: widget.item.image.startsWith('http')
            ? Image.network(
                widget.item.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholderImage(),
              )
            : Image.asset(
                widget.item.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholderImage(),
              ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFFF6B35).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.restaurant_menu,
        color: Color(0xFFFF6B35),
        size: 32,
      ),
    );
  }

  Widget _buildItemDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Item name
        Text(
          widget.item.name,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 4),

        // Item description
        if (widget.item.description != null)
          Text(
            widget.item.description!,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

        const SizedBox(height: 8),

        // Price
        Row(
          children: [
            Text(
              '\$${widget.item.price.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFF6B35),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '× ${widget.item.quantity}',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityControls() {
    return Column(
      children: [
        // Remove button
        GestureDetector(
          onTap: widget.onRemove,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.close, size: 16, color: Colors.red),
          ),
        ),

        const SizedBox(height: 16),

        // Quantity controls
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              // Increase button
              GestureDetector(
                onTap: () => _handleQuantityChange(1),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: widget.item.quantity < widget.item.maxQuantity
                        ? const Color(0xFFFF6B35)
                        : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 16,
                    color: widget.item.quantity < widget.item.maxQuantity
                        ? Colors.white
                        : Colors.grey.shade500,
                  ),
                ),
              ),

              // Quantity display
              Container(
                width: 32,
                height: 24,
                alignment: Alignment.center,
                child: Text(
                  widget.item.quantity.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Decrease button
              GestureDetector(
                onTap: () => _handleQuantityChange(-1),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: widget.item.quantity > 1
                        ? const Color(0xFFFF6B35)
                        : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.remove,
                    size: 16,
                    color: widget.item.quantity > 1
                        ? Colors.white
                        : Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
