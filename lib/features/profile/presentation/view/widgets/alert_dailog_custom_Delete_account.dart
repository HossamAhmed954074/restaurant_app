// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_app/core/router/app_router.dart';
import 'package:resturant_app/core/utils/widgets/show_circle_indecator.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_faluire.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_sucess.dart';
import 'package:resturant_app/features/auth/view/widgets/text_field_custom.dart';
import 'package:resturant_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AlertDaialogCustomDeleteAccount extends StatefulWidget {
  const AlertDaialogCustomDeleteAccount({super.key});

  @override
  State<AlertDaialogCustomDeleteAccount> createState() =>
      _AlertDaialogCustomDeleteAccountState();
}

class _AlertDaialogCustomDeleteAccountState
    extends State<AlertDaialogCustomDeleteAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  deleteAccount() {
    BlocProvider.of<ProfileCubit>(context).deleteAccount(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  _onGetStarted() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('onboarding', false);
  }

  logOut() async {
    await BlocProvider.of<ProfileCubit>(context).logOut();
    await _onGetStarted();
    if (mounted) {
      GoRouter.of(context).go(AppRouter.kOnboardingScreen);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileDeleteAccountFailure) {
          showSnakBarFaluire(context, state.message.userFriendlyMessage);
        }
        if (state is ProfileDeleteAccountSuccess) {
          showSnakBarSuccess(context, 'Account deleted successfully');
          logOut();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            AlertDialog(
              backgroundColor: Colors.blueAccent,
              title: Text(
                'Delete account',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Are you sure you want to delete your account?',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 15),
                    TextFieldCustomWidget(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    SizedBox(height: 15),
                    TextFieldCustomWidget(
                      hintText: 'Password',
                      controller: _passwordController,
                    ),

                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              deleteAccount();
                            }
                          },
                          child: Text('Delete '),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (state is ProfileDeleteAccountLoading)
              circleIndeactorCustom(context),
          ],
        );
      },
    );
  }
}
