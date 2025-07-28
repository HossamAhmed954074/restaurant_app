import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resturant_app/features/bottom_nave/models/bottom_nav_models.dart';
import 'package:resturant_app/features/bottom_nave/widgets/enhanced_bottom_nav_bar.dart';
import 'package:resturant_app/features/bottom_nave/widgets/badge_widget.dart';
import 'package:resturant_app/features/cart/presentation/view/screens/cart_screen.dart';
import 'package:resturant_app/features/home/presentation/view/screens/enhanced_home_screen.dart';
import 'package:resturant_app/features/profile/presentation/view/screens/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  late BottomNavState _navState;
  late AnimationController _pageController;
  late Animation<double> _pageAnimation;

  final List<Widget> _screens = [
    const EnhancedHomeScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeState();
    _initializeAnimations();
  }

  void _initializeState() {
    _navState = BottomNavState(
      currentIndex: 0,
      isAnimating: false,
      lastTapTime: DateTime.now(),
    );
  }

  void _initializeAnimations() {
    _pageController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _pageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pageController, curve: Curves.easeInOutCubic),
    );

    // Start with first page animation
    _pageController.forward();
  }

  void _handleNavigation(int index) {
    if (_navState.isAnimating || index == _navState.currentIndex) {
      return;
    }

    // Haptic feedback
    HapticFeedback.selectionClick();

    setState(() {
      _navState = _navState.copyWith(
        currentIndex: index,
        isAnimating: true,
        lastTapTime: DateTime.now(),
      );
    });

    // Animate page transition
    _pageController.reset();
    _pageController.forward().then((_) {
      setState(() {
        _navState = _navState.copyWith(isAnimating: false);
      });
    });
  }

  List<BottomNavItem> get _navigationItems => [
    BottomNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    BottomNavItem(
      icon: Icons.shopping_cart_outlined,
      activeIcon: Icons.shopping_cart,
      label: 'Cart',
      badgeBuilder: (context) => const BadgeWidget(count: 3),
    ),
    BottomNavItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
      badgeBuilder: (context) => const DotBadgeWidget(),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF8F9FA),
      body: AnimatedBuilder(
        animation: _pageAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: 0.95 + (0.05 * _pageAnimation.value),
            child: Opacity(
              opacity: 0.3 + (0.7 * _pageAnimation.value),
              child: _screens[_navState.currentIndex],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.05)],
            stops: const [0.0, 1.0],
          ),
        ),
        child: EnhancedBottomNavBar(
          items: _navigationItems,
          currentIndex: _navState.currentIndex,
          onTap: _handleNavigation,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFFFF6B35),
          unselectedItemColor: Colors.grey.shade600,
          showLabels: true,
          elevation: 12.0,
          enableHapticFeedback: true,
        ),
      ),
    );
  }
}
