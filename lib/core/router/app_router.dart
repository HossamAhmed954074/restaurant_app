import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_app/core/services/auth_services.dart';
import 'package:resturant_app/features/auth/view/screens/auth_screen.dart';
import 'package:resturant_app/features/auth/view_model/cubit/auth_cubit.dart';
import 'package:resturant_app/features/bottom_nave/screens/bottom_nav.dart';
import 'package:resturant_app/features/get_started/screens/get_started_screen.dart';
import 'package:resturant_app/features/onboarding/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRouter {
  static const kOnboardingScreen = '/';
  static const kGetStartedScreen = '/get-started';
  static const kAuthScreen = '/auth';
  static const kBottomNavBarScreen = '/bottom-nav-bar';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: kOnboardingScreen,
        builder: (context, state) {
           SharedPreferences.getInstance().then((value) {
            if (value.getBool('onboarding') == true) {
              AuthServicess().authStateChanges.listen((User? user) {
                if (user != null) {
                  if (context.mounted) {
                    GoRouter.of(context).go(kBottomNavBarScreen);
                  }
                } else {
                  if (context.mounted) {
                    GoRouter.of(context).go(kGetStartedScreen);
                  }
                }
              });
            } else {
               return const OnboardingScreen();
            }
          });
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
        path: kBottomNavBarScreen,
        builder: (context, state) => const BottomNav(),
      ),
      GoRoute(
        path: kAuthScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => AuthCubit(AuthServicess()),
            child: const AuthScreen(),
          );
        },
      ),
    ],
  );
}
