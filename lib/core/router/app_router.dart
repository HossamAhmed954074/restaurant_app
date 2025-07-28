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
import 'package:resturant_app/features/details/presentation/view/screens/item_details_screen.dart';
import 'package:resturant_app/features/details/presentation/view_model/cubit/order_cubit.dart';
import 'package:resturant_app/features/get_started/screens/get_started_screen.dart';
import 'package:resturant_app/features/home/data/item_data.dart';
import 'package:resturant_app/features/onboarding/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Helper class to create a listenable from a stream for GoRouter refresh
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// Centralized router configuration for the restaurant app
/// Handles navigation between onboarding, authentication, and main app screens
class AppRouter {
  // Route path constants
  static const String kOnboardingScreen = '/';
  static const String kGetStartedScreen = '/get-started';
  static const String kAuthScreen = '/auth';
  static const String kBottomNavBarScreen = '/bottom-nav-bar';
  static const String kMenuDetailsScreen = '/menu-details';

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
      refreshListenable: GoRouterRefreshStream(_authService.authStateChanges),
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
      log('Redirect check - Current path: $currentPath', name: 'AppRouter');

      // Get onboarding status
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool hasSeenOnboarding = prefs.getBool(_onboardingKey) ?? false;

      // Get current user
      final User? currentUser = _authService.currentUser;

      log(
        'Redirect state - Onboarding: $hasSeenOnboarding, User: ${currentUser?.uid ?? 'null'}',
        name: 'AppRouter',
      );

      // Step 1: Handle onboarding flow - ONLY redirect if onboarding not seen
      if (!hasSeenOnboarding) {
        log(
          'User needs onboarding, current path: $currentPath',
          name: 'AppRouter',
        );
        return currentPath == kOnboardingScreen ? null : kOnboardingScreen;
      }

      // Step 2: Handle authenticated users (onboarding completed)
      if (currentUser != null) {
        log(
          'User is authenticated, current path: $currentPath',
          name: 'AppRouter',
        );

        // Only redirect from auth-related screens to main app
        if (currentPath == kOnboardingScreen ||
            currentPath == kGetStartedScreen ||
            currentPath == kAuthScreen) {
          log('Redirecting authenticated user to main app', name: 'AppRouter');
          return kBottomNavBarScreen;
        }

        // Allow all other paths for authenticated users
        return null;
      }

      // Step 3: Handle unauthenticated users (onboarding completed)
      log(
        'User is not authenticated, current path: $currentPath',
        name: 'AppRouter',
      );

      // Only redirect from protected routes
      if (currentPath == kBottomNavBarScreen ||
          currentPath == kMenuDetailsScreen) {
        log(
          'Redirecting from protected route to get started',
          name: 'AppRouter',
        );
        return kGetStartedScreen;
      }

      // For onboarding screen when onboarding is complete and user not authenticated
      if (currentPath == kOnboardingScreen) {
        log(
          'Redirecting from completed onboarding to get started',
          name: 'AppRouter',
        );
        return kGetStartedScreen;
      }

      // Allow access to get-started and auth screens
      log('No redirect needed for path: $currentPath', name: 'AppRouter');
      return null;
    } catch (e) {
      log('Error in redirect logic: $e', name: 'AppRouter');
      return null; // Don't redirect on error to prevent loops
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
        path: kMenuDetailsScreen,
        name: 'menu-details',
        builder: (context, state) {
          final itemData = state.extra as Itemdata;
          return BlocProvider(
            create: (context) => OrderCubit(),
            child: ItemDetailsScreen(itemData: itemData),
          );
        },
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
        builder: (context, state) => const BottomNavBar(),
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

  /// Marks onboarding as completed and navigates to get started screen
  static Future<void> completeOnboarding(BuildContext context) async {
    try {
      log('Completing onboarding...', name: 'AppRouter');

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_onboardingKey, true);

      log('Onboarding marked as complete', name: 'AppRouter');

      // Use pushReplacement to prevent going back to onboarding
      if (context.mounted) {
        log('Navigating to get started screen...', name: 'AppRouter');
        context.pushReplacement(kGetStartedScreen);
      }
    } catch (e) {
      log('Error completing onboarding: $e', name: 'AppRouter');
      // Fallback navigation
      if (context.mounted) {
        context.go(kGetStartedScreen);
      }
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
