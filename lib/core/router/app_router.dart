import 'package:go_router/go_router.dart';
import 'package:resturant_app/features/auth/view/screens/auth_screen.dart';
import 'package:resturant_app/features/get_started/screens/get_started_screen.dart';
import 'package:resturant_app/features/onboarding/screens/onboarding_screen.dart';

class AppRouter {
  static const kOnboardingScreen = '/';
  static const kGetStartedScreen = '/get-started';
  static const kAuthScreen = '/auth';



  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: kOnboardingScreen,
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        path: kGetStartedScreen,
        builder: (context, state) {
          return const GetStartedScreen();
        },
      ),
      GoRoute(
        path: kAuthScreen,
        builder: (context, state) {
          return const AuthScreen();
        },
      ),
    ],
  );
}
