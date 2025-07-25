

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_app/core/router/app_router.dart';
import 'package:resturant_app/core/services/auth_services.dart';
import 'package:resturant_app/features/profile/presentation/view/widgets/alert_dailog_custom.dart';
import 'package:resturant_app/features/profile/presentation/view/widgets/alert_dailog_custom_Delete_account.dart';
import 'package:resturant_app/features/profile/presentation/view/widgets/alert_dailog_custom_user_name.dart';
import 'package:resturant_app/features/profile/presentation/view/widgets/build_setting_opthion.dart';
import 'package:resturant_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SettingsSection extends StatefulWidget {
  const SettingsSection({super.key});

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Settings",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        Divider(color: Colors.black),
        SizedBox(height: 10),

        if(AuthServicess().currentUser != null)
          checckProvider(),
        

       
        BuildSettingsOption(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Logout'),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        logOut();
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          icon: Icons.logout,
          text: "Logout",
          iconColor: Colors.red,
        ),
      ],
    );
  }

  Widget checckProvider() {
    return Column(
      children: [
        BuildSettingsOption(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return BlocProvider(
                  create: (context) => ProfileCubit(AuthServicess()),
                  child: AlertDaialogCustomUpdateUserName(),
                );
              },
            );
          },
          icon: Icons.edit,
          text: "Update username",
        ),
        BuildSettingsOption(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return BlocProvider(
                  create: (context) => ProfileCubit(AuthServicess()),
                  child: AlertDialogCustomWidget(),
                );
              },
            );
          },
          icon: Icons.lock,
          text: "Change password",
        ),
        BuildSettingsOption(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return BlocProvider(
                  create: (context) => ProfileCubit(AuthServicess()),
                  child: AlertDaialogCustomDeleteAccount(),
                );
              },
            );
          },
          icon: Icons.delete,
          text: "Delete my account",
        ),
      ],
    );
  }
}

