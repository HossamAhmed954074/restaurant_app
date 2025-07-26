import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_app/core/utils/widgets/show_circle_indecator.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_faluire.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_sucess.dart';
import 'package:resturant_app/features/auth/view/widgets/auth_button_custom.dart';
import 'package:resturant_app/features/auth/view/widgets/text_field_custom.dart';
import 'package:resturant_app/features/auth/view_model/cubit/auth_cubit.dart';
import '../../../../core/router/app_router.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState?.dispose();
  }

  void logIn() {
    BlocProvider.of<AuthCubit>(context).logIn(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
  }

  void navigateTo() async {
    if (mounted) {
      GoRouter.of(context).go(AppRouter.kBottomNavBarScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          showSnakBarSuccess(context, 'Login Success');
          navigateTo();
        } else if (state is AuthFailure) {
          showSnakBarFaluire(context, state.message.faliure());
          clear();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldCustomWidget(
                      hintText: 'Email',
                      controller: emailController,
                    ),
                    SizedBox(height: 15),
                    TextFieldCustomWidget(
                      hintText: 'Password',
                      controller: passwordController,
                    ),
                    SizedBox(height: 10),
                    //  CheckBoxRememberMe(onChanged: (p0) {}),
                    SizedBox(height: 30),
                    AuthButtonCustomWidget(
                      text: 'LogIN',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          logIn();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
              if (state is AuthLoading) circleIndeactorCustom(context),
          ],
        );
      },
    );
  }
}
