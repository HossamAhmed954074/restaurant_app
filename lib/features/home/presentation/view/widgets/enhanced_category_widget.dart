import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_app/features/home/data/category_item_data.dart';

class EnhancedCategoryWidget extends StatefulWidget {
  const EnhancedCategoryWidget({super.key, required this.onCategorySelected});

  final Function(String) onCategorySelected;

  @override
  State<EnhancedCategoryWidget> createState() => _EnhancedCategoryWidgetState();
}

class _EnhancedCategoryWidgetState extends State<EnhancedCategoryWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<AnimationController> _itemControllers;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _itemControllers = List.generate(
      categoryItems.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 400 + (index * 100)),
        vsync: this,
      ),
    );

    // Start animations with staggered effect
    _animationController.forward();
    for (int i = 0; i < _itemControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) {
          _itemControllers[i].forward();
        }
      });
    }
  }

  void _onCategoryTap(int index) {
    if (_selectedIndex == index) return;

    HapticFeedback.selectionClick();

    setState(() {
      _selectedIndex = index;
    });

    widget.onCategorySelected(categoryItems[index].title);
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Show all categories
                },
                child: Text(
                  'See All',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFFF6B35),
                  ),
                ),
              ),
            ],
          ),
        ),

      //  const SizedBox(height: 16),

        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categoryItems.length,
            itemBuilder: (context, index) {
              final category = categoryItems[index];
              final isSelected = index == _selectedIndex;

              return AnimatedBuilder(
                animation: _itemControllers[index],
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, 50 * (1 - _itemControllers[index].value)),
                    child: Opacity(
                      opacity: _itemControllers[index].value,
                      child: GestureDetector(
                        onTap: () => _onCategoryTap(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.only(
                            right: index == categoryItems.length - 1 ? 0 : 16,
                          ),
                          child: _buildCategoryItem(
                            category: category,
                            isSelected: isSelected,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem({
    required CategoryItemData category,
    required bool isSelected,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 80,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFF6B35) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? const Color(0xFFFF6B35).withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
            blurRadius: isSelected ? 15 : 8,
            spreadRadius: 0,
            offset: Offset(0, isSelected ? 8 : 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon Container
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withValues(alpha: 0.2)
                  : const Color(0xFFFF6B35).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Image.asset(
                category.imageCategory,
                width: 35,
                height: 35,
                //color: isSelected ? Colors.white : const Color(0xFFFF6B35),
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.restaurant_menu,
                    size: 28,
                    color: isSelected ? Colors.white : const Color(0xFFFF6B35),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Category Name
          Text(
            category.title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black87,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
