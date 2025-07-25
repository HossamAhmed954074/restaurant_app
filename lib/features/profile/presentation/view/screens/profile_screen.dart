import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app/core/services/auth_services.dart';
import 'package:resturant_app/features/profile/presentation/view/widgets/info_section.dart';
import 'package:resturant_app/features/profile/presentation/view/widgets/setting_section.dart';
import 'package:resturant_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Container(
          //color: Colors.white, // Background color set to white
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                // Info Section
                InfoSection(),
                SizedBox(height: 30),
                // Settings Section
                BlocProvider(
                  create: (context) => ProfileCubit(AuthServicess()),
                  child: SettingsSection(),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
