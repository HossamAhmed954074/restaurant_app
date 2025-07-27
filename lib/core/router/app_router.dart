import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_app/core/services/auth_services.dart';
import 'package:resturant_app/features/auth/view/screens/auth_screen.dart';
import 'package:resturant_app/features/auth/view_model/cubit/auth_cubit.dart';
import 'package:resturant_app/features/bottom_nave/screens/bottom_nav.dart';
import 'package:resturant_app/features/get_started/screens/get_started_screen.dart';
import 'package:resturant_app/features/onboarding/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Centralized router configuration for the restaurant app
/// Handles navigation between onboarding, authentication, and main app screens
class AppRouter {
  // Route path constants
  static const String kOnboardingScreen = '/';
  static const String kGetStartedScreen = '/get-started';
  static const String kAuthScreen = '/auth';
  static const String kBottomNavBarScreen = '/bottom-nav-bar';

  // SharedPreferences keys
  static const String _onboardingKey = 'onboarding';

  // Singleton instances
  static final AuthServicess _authService = AuthServicess();

  /// Creates and configures the GoRouter instance
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: kOnboardingScreen,
      debugLogDiagnostics: true,
      redirect: _handleRedirect,
      routes: _buildRoutes(),
      errorBuilder: (context, state) => _buildErrorScreen(state.error),
    );
  }

  /// Main router instance
  static final GoRouter router = createRouter();

  /// Handles global redirect logic based on app state
  static Future<String?> _handleRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    try {
      final String currentPath = state.matchedLocation;
      log('Current path: $currentPath', name: 'AppRouter');

      // Get onboarding status
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool hasSeenOnboarding = prefs.getBool(_onboardingKey) ?? false;

      // Get current user
      final User? currentUser = _authService.currentUser;

      log(
        'Has seen onboarding: $hasSeenOnboarding, Current user: ${currentUser?.uid}',
        name: 'AppRouter',
      );

      // If user hasn't seen onboarding, show onboarding screen
      if (!hasSeenOnboarding && currentPath != kOnboardingScreen) {
        return kOnboardingScreen;
      }

      // If user has seen onboarding but is on onboarding screen, redirect based on auth
      if (hasSeenOnboarding && currentPath == kOnboardingScreen) {
        return currentUser != null ? kBottomNavBarScreen : kGetStartedScreen;
      }

      // If user is authenticated but on get-started or auth screen, go to main app
      if (currentUser != null &&
          (currentPath == kGetStartedScreen || currentPath == kAuthScreen)) {
        return kBottomNavBarScreen;
      }

      // If user is not authenticated but trying to access main app, go to get-started
      if (currentUser == null && currentPath == kBottomNavBarScreen) {
        return kGetStartedScreen;
      }

      // No redirect needed
      return null;
    } catch (e) {
      log('Error in redirect logic: $e', name: 'AppRouter');
      return kOnboardingScreen; // Safe fallback
    }
  }

  /// Builds the route configuration
  static List<RouteBase> _buildRoutes() {
    return [
      GoRoute(
        path: kOnboardingScreen,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: kGetStartedScreen,
        name: 'get-started',
        builder: (context, state) => const GetStartedScreen(),
      ),
      GoRoute(
        path: kAuthScreen,
        name: 'auth',
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(_authService),
          child: const AuthScreen(),
        ),
      ),
      GoRoute(
        path: kBottomNavBarScreen,
        name: 'main-app',
        builder: (context, state) => const BottomNav(),
      ),
    ];
  }

  /// Builds error screen for routing errors
  static Widget _buildErrorScreen(Exception? error) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Error'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Navigation Error',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                error?.toString() ?? 'An unknown navigation error occurred',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Navigate to home/onboarding as safe fallback
                  GoRouter.of(
                    router.routerDelegate.navigatorKey.currentContext!,
                  ).go(kOnboardingScreen);
                },
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Marks onboarding as completed
  static Future<void> completeOnboarding() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_onboardingKey, true);
      log('Onboarding marked as completed', name: 'AppRouter');
    } catch (e) {
      log('Error marking onboarding as completed: $e', name: 'AppRouter');
    }
  }

  /// Clears onboarding status (useful for testing or reset functionality)
  static Future<void> resetOnboarding() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_onboardingKey);
      log('Onboarding status reset', name: 'AppRouter');
    } catch (e) {
      log('Error resetting onboarding: $e', name: 'AppRouter');
    }
  }

  /// Gets current authentication state
  static User? get currentUser => _authService.currentUser;

  /// Gets authentication state stream
  static Stream<User?> get authStateChanges => _authService.authStateChanges;
}
