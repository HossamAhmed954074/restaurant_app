import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_app/features/bottom_nave/models/bottom_nav_models.dart';

class EnhancedBottomNavBar extends StatefulWidget {
  const EnhancedBottomNavBar({
    super.key,
    required this.items,
    required this.onTap,
    this.currentIndex = 0,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.showLabels = true,
    this.type = BottomNavigationBarType.shifting,
    this.elevation = 8.0,
    this.enableHapticFeedback = true,
  });

  final List<BottomNavItem> items;
  final ValueChanged<int> onTap;
  final int currentIndex;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final bool showLabels;
  final BottomNavigationBarType type;
  final double elevation;
  final bool enableHapticFeedback;

  @override
  State<EnhancedBottomNavBar> createState() => _EnhancedBottomNavBarState();
}

class _EnhancedBottomNavBarState extends State<EnhancedBottomNavBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _badgeController;
  late List<AnimationController> _itemControllers;

  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _badgeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _itemControllers = List.generate(
      widget.items.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      ),
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
    _badgeController.repeat(reverse: true);
  }

  void _handleTap(int index) {
    if (widget.enableHapticFeedback) {
      HapticFeedback.selectionClick();
    }

    // Animate the tapped item
    _itemControllers[index].forward().then((_) {
      _itemControllers[index].reverse();
    });

    widget.onTap(index);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _badgeController.dispose();
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(_slideAnimation),
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: widget.elevation,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            height: kBottomNavigationBarHeight + 20,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widget.items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected = index == widget.currentIndex;

                return _buildNavItem(
                  item: item,
                  index: index,
                  isSelected: isSelected,
                  colorScheme: colorScheme,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BottomNavItem item,
    required int index,
    required bool isSelected,
    required ColorScheme colorScheme,
  }) {
    final selectedColor = widget.selectedItemColor ?? colorScheme.primary;
    final unselectedColor =
        widget.unselectedItemColor ?? colorScheme.onSurface.withValues(alpha: 0.6);
    final itemColor = isSelected ? selectedColor : unselectedColor;

    return Flexible(
      child: InkWell(
        onTap: () => _handleTap(index),
        borderRadius: BorderRadius.circular(16),
        child: AnimatedBuilder(
          animation: _itemControllers[index],
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (_itemControllers[index].value * 0.1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon with badge
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Icon container with background
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? selectedColor.withValues(alpha: 0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            isSelected && item.activeIcon != null
                                ? item.activeIcon
                                : item.icon,
                            color: itemColor,
                            size: 22,
                          ),
                        ),

                        // Badge
                        if (item.badgeBuilder != null)
                          Positioned(
                            right: -4,
                            top: -4,
                            child: ScaleTransition(
                              scale: Tween<double>(
                                begin: 0.8,
                                end: 1.2,
                              ).animate(_badgeController),
                              child: item.badgeBuilder!(context),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 1),

                    // Label
                    if (widget.showLabels)
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: GoogleFonts.poppins(
                          fontSize: isSelected ? 11 : 9,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: itemColor,
                        ),
                        child: Text(
                          item.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
