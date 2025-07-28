import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_app/core/router/app_router.dart';
import 'package:resturant_app/features/onboarding/models/onboarding_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../generated/assets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _buttonController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _buttonScaleAnimation;

  int currentPage = 0;
  bool _isLoading = false;

  // Enhanced onboarding data with more engaging content
  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      imagePath: Assets.onboardingOnboarding1,
      title: 'Discover Amazing Restaurants',
      subtitle: 'Explore the finest dining experiences in London',
      description:
          'Find top-rated restaurants, read reviews, and discover hidden gems in your neighborhood.',
      primaryColor: Colors.orange,
      secondaryColor: Colors.brown,
    ),
    OnboardingData(
      imagePath: Assets.onboardingOnboarding2,
      title: 'Order Your Favorites',
      subtitle: 'Delicious meals delivered to your doorstep',
      description:
          'Browse extensive menus, customize your orders, and enjoy fast, reliable delivery service.',
      primaryColor: Colors.green,
      secondaryColor: Colors.teal,
    ),
    OnboardingData(
      imagePath: Assets.onboardingOnboarding3,
      title: 'Enjoy Every Bite',
      subtitle: 'Your culinary journey begins here',
      description:
          'Track your orders in real-time, save favorites, and become part of our food-loving community.',
      primaryColor: Colors.purple,
      secondaryColor: Colors.indigo,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startInitialAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
        );

    _buttonScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.elasticOut),
    );
  }

  void _startInitialAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _fadeController.forward();
        _slideController.forward();
        _buttonController.forward();
      }
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });

    // Restart animations for new page
    _fadeController.reset();
    _slideController.reset();
    _buttonController.reset();

    _startInitialAnimations();
    HapticFeedback.selectionClick();
  }

  void _skip() {
    _pageController.animateToPage(
      _onboardingData.length - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    HapticFeedback.mediumImpact();
  }

  void _onNext() {
    if (currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      HapticFeedback.lightImpact();
    }
  }

  void _onGetStarted() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    HapticFeedback.heavyImpact();

    try {
      // First, mark onboarding as completed using the AppRouter method
      await AppRouter.completeOnboarding(context);

      // Add a slight delay for better UX
      await Future.delayed(const Duration(milliseconds: 300));

      // Then navigate to get started screen
      if (mounted) {
        GoRouter.of(context).go(AppRouter.kGetStartedScreen);
      }
    } catch (e) {
      // Fallback: manually set the preference if AppRouter method fails
      try {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setBool('onboarding', true);
        if (mounted) {
          GoRouter.of(context).go(AppRouter.kGetStartedScreen);
        }
      } catch (fallbackError) {
        // If everything fails, at least try to navigate
        if (mounted) {
          GoRouter.of(context).go(AppRouter.kGetStartedScreen);
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      body: Container(
        decoration: _buildGradientBackground(),
        child: SafeArea(
          child: Column(
            children: [
              // Header with progress indicators
              _buildHeader(isTablet),

              // Main content with PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) {
                    return _buildOnboardingPage(
                      _onboardingData[index],
                      isTablet,
                    );
                  },
                ),
              ),

              // Bottom navigation and page indicator
              _buildBottomNavigation(isTablet),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildGradientBackground() {
    final currentData = _onboardingData[currentPage];
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          currentData.primaryColor.withValues(alpha: 0.1),
          Colors.white,
          currentData.secondaryColor.withValues(alpha: 0.05),
        ],
        stops: const [0.0, 0.5, 1.0],
      ),
    );
  }

  Widget _buildHeader(bool isTablet) {
    return Padding(
      padding: EdgeInsets.all(isTablet ? 32 : 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // App logo/brand
          FadeTransition(
            opacity: _fadeAnimation,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _onboardingData[currentPage].primaryColor
                        .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.restaurant_menu,
                    color: _onboardingData[currentPage].primaryColor,
                    size: isTablet ? 24 : 20,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'FoodBuddy',
                  style: GoogleFonts.lobster(
                    fontSize: isTablet ? 20 : 16,
                    fontWeight: FontWeight.bold,
                    color: _onboardingData[currentPage].primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Skip button
          if (currentPage != _onboardingData.length - 1)
            ScaleTransition(
              scale: _buttonScaleAnimation,
              child: TextButton(
                onPressed: _skip,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 20 : 16,
                    vertical: isTablet ? 12 : 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Skip',
                  style: GoogleFonts.poppins(
                    fontSize: isTablet ? 16 : 14,
                    fontWeight: FontWeight.w500,
                    color: _onboardingData[currentPage].primaryColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingData data, bool isTablet) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 20),
      child: Column(
        children: [
          // Main illustration with enhanced styling
          Expanded(
            flex: 3,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: isTablet ? 40 : 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: data.primaryColor.withValues(alpha: 0.2),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          data.primaryColor.withValues(alpha: 0.1),
                          Colors.white,
                          data.secondaryColor.withValues(alpha: 0.05),
                        ],
                      ),
                    ),
                    child: Image.asset(data.imagePath, fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
          ),

          // Content section
          Expanded(
            flex: 2,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
               // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    data.title,
                    style: GoogleFonts.poppins(
                      fontSize: isTablet ? 32 : 26,
                      fontWeight: FontWeight.bold,
                      color: data.primaryColor,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: isTablet ? 16 : 0),

                  // Subtitle
                  Text(
                    data.subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: isTablet ? 18 : 14,
                      fontWeight: FontWeight.w600,
                      color: data.secondaryColor,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: isTablet ? 20 : 10),

                  // Description
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      data.description,
                      style: GoogleFonts.poppins(
                        fontSize: isTablet ? 16 : 14,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 32 : 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Page indicator
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingData.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? _onboardingData[currentPage].primaryColor
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),

          // Action button
          ScaleTransition(
            scale: _buttonScaleAnimation,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : (currentPage == _onboardingData.length - 1
                          ? _onGetStarted
                          : _onNext),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _onboardingData[currentPage].primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: isTablet ? 20 : 16,
                    horizontal: 32,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  shadowColor: _onboardingData[currentPage].primaryColor
                      .withValues(alpha: 0.3),
                ),
                child: _isLoading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            currentPage == _onboardingData.length - 1
                                ? 'Get Started'
                                : 'Next',
                            style: GoogleFonts.poppins(
                              fontSize: isTablet ? 18 : 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            currentPage == _onboardingData.length - 1
                                ? Icons.rocket_launch_rounded
                                : Icons.arrow_forward_rounded,
                            size: isTablet ? 24 : 20,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
