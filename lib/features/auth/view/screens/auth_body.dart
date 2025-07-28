import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:resturant_app/features/auth/view/widgets/login_body.dart';
import 'package:resturant_app/features/auth/view/widgets/register_body.dart';
import 'package:resturant_app/features/auth/view/widgets/resset_passord_body.dart';
import 'package:resturant_app/features/auth/view/widgets/tab_bar_custom.dart';
import 'package:resturant_app/generated/assets.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({super.key});

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Stack(
      children: [
        // Background Image
        _buildBackgroundImage(),

        // Overlay
        _buildOverlay(),

        // Main Content
        _buildMainContent(context, size, isTablet),
      ],
    );
  }

  Widget _buildBackgroundImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.imagesAuth),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.3),
            Colors.black.withValues(alpha: 0.6),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, Size size, bool isTablet) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? size.width * 0.1 : 20,
          vertical: 20,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isTablet ? 500 : double.infinity,
            minHeight: size.height * 0.6,
          ),
          child: _buildAuthContainer(context, size, isTablet),
        ),
      ),
    );
  }

  Widget _buildAuthContainer(BuildContext context, Size size, bool isTablet) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with app branding
              _buildHeader(context),

              // Tab Bar
              TabBarCustomWidget(tabController: _tabController),

              // Tab Content
              _buildTabContent(size, isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(
        children: [
          // App Icon or Logo
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.restaurant_menu,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),

          // Welcome Text
          const Text(
            'Welcome',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sign in to your account or create a new one',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(Size size, bool isTablet) {
    return SizedBox(
      height: isTablet ? 400 : size.height * 0.45,
      child: TabBarView(
        controller: _tabController,
        children: [
          LoginBody(onSwitchToResetPassword: () => _tabController.animateTo(2)),
          RegisterBody(onSwitchToLogin: () => _tabController.animateTo(0)),
          RessetPassord(onBackToLogin: () => _tabController.animateTo(0)),
        ],
      ),
    );
  }
}
