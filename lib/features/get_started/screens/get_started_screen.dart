import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_app/core/router/app_router.dart';
import 'package:resturant_app/generated/assets.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    // Fade animation for images and text
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Slide animation for button
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
        );

    // Pulse animation for button hover effect
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _fadeController.forward();
      }
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        _slideController.forward();
      }
    });
  }

  void _handleGetStarted() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Haptic feedback
    HapticFeedback.mediumImpact();

    // Add slight delay for better UX
    await Future.delayed(const Duration(milliseconds: 300));

    if (mounted) {
      GoRouter.of(context).pushReplacement(AppRouter.kAuthScreen);
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 40 : 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                // Skip button (top right)
                _buildSkipButton(),

                // Main content
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildMainContent(size, isTablet),
                  ),
                ),

                // Get Started button
                _buildGetStartedButton(isTablet),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildGradientBackground() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.orange.shade50, Colors.white, Colors.brown.shade50],
        stops: const [0.0, 0.5, 1.0],
      ),
    );
  }

  Widget _buildSkipButton() {
    return Align(
      alignment: Alignment.topRight,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: TextButton(
          onPressed: _handleGetStarted,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            'Skip',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.brown.shade600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(Size size, bool isTablet) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: size.height * 0.6, // Ensure minimum height for centering
      ),
      child: IntrinsicHeight(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add flexible spacing at top
            const Spacer(flex: 1),

            // Logo/Brand section
            FadeTransition(
              opacity: _fadeAnimation,
              child: _buildBrandSection(isTablet),
            ),

            SizedBox(height: isTablet ? 30 : 20),

            // Main illustration
            FadeTransition(
              opacity: _fadeAnimation,
              child: _buildMainIllustration(size, isTablet),
            ),

            SizedBox(height: isTablet ? 40 : 25),

            // Welcome text section
            FadeTransition(
              opacity: _fadeAnimation,
              child: _buildWelcomeText(isTablet),
            ),

            // Add flexible spacing at bottom
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandSection(bool isTablet) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.restaurant_menu,
              color: Colors.brown.shade600,
              size: isTablet ? 32 : 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'FoodBuddy',
            style: GoogleFonts.lobster(
              fontSize: isTablet ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.brown.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainIllustration(Size size, bool isTablet) {
    // Calculate responsive dimensions
    final maxSize = isTablet ? 280.0 : size.height * 0.25;
    final containerSize = maxSize.clamp(200.0, 300.0);

    return Container(
      constraints: BoxConstraints(
        maxHeight: containerSize,
        maxWidth: containerSize,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background decoration
          Container(
            width: containerSize,
            height: containerSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Colors.orange.withValues(alpha: 0.1), Colors.transparent],
                stops: const [0.5, 1.0],
              ),
            ),
          ),

          // Logo image
          Container(
            padding: const EdgeInsets.all(16),
            child: Image.asset(
              Assets.getStartedGetstarted2,
              height: isTablet ? 80 : 60,
              fit: BoxFit.contain,
            ),
          ),

          // Main illustration
          Positioned(
            bottom: 10,
            child: Container(
              constraints: BoxConstraints(maxHeight: containerSize * 0.7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  Assets.getStartedGetStarted,
                  height: isTablet ? 180 : 140,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeText(bool isTablet) {
    return Column(
      children: [
        Text(
          'Your New Food Buddy',
          style: GoogleFonts.poppins(
            fontSize: isTablet ? 28 : 22,
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade800,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: isTablet ? 16 : 12),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Discover delicious meals, order with ease, and enjoy every bite. Your culinary journey starts here!',
            style: GoogleFonts.poppins(
              fontSize: isTablet ? 16 : 14,
              color: Colors.brown.shade600,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        SizedBox(height: isTablet ? 20 : 16),

        // Feature highlights
        _buildFeatureHighlights(isTablet),
      ],
    );
  }

  Widget _buildFeatureHighlights(bool isTablet) {
    final features = [
      {'icon': Icons.search, 'text': 'Discover'},
      {'icon': Icons.shopping_cart, 'text': 'Order'},
      {'icon': Icons.favorite, 'text': 'Enjoy'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: features.map((feature) {
        return Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(isTablet ? 12 : 8),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  feature['icon'] as IconData,
                  color: Colors.brown.shade600,
                  size: isTablet ? 20 : 16,
                ),
              ),
              SizedBox(height: isTablet ? 8 : 6),
              Text(
                feature['text'] as String,
                style: GoogleFonts.poppins(
                  fontSize: isTablet ? 12 : 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.brown.shade600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGetStartedButton(bool isTablet) {
    return SlideTransition(
      position: _slideAnimation,
      child: MouseRegion(
        onEnter: (_) => _pulseController.forward(),
        onExit: (_) => _pulseController.reverse(),
        child: ScaleTransition(
          scale: _pulseAnimation,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleGetStarted,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade600,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: isTablet ? 20 : 16,
                  horizontal: 32,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: Colors.brown.shade300,
              ),
              child: _isLoading
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Get Started',
                          style: GoogleFonts.poppins(
                            fontSize: isTablet ? 18 : 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: isTablet ? 24 : 20,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
