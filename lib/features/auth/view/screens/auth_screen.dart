import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_app/core/router/app_router.dart';
import 'package:resturant_app/core/services/auth_services.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_faluire.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_sucess.dart';
import 'package:resturant_app/features/auth/view/screens/auth_body.dart';
import 'package:resturant_app/features/auth/view_model/cubit/auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthServicess()),
      child: const AuthScreenBody(),
    );
  }
}

class AuthScreenBody extends StatelessWidget {
  const AuthScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          _handleAuthStateChanges(context, state);
        },
        child: const SafeArea(child: AuthBody()),
      ),
    );
  }

  void _handleAuthStateChanges(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      showSnakBarSuccess(context, 'Authentication successful!');
      // Navigate to main app after successful authentication
      context.go(AppRouter.kBottomNavBarScreen);
    } else if (state is AuthFailure) {
      showSnakBarFaluire(context, state.message.userFriendlyMessage);
    }
  }
}
