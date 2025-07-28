import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app/core/services/auth_services.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_faluire.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_sucess.dart';
import 'package:resturant_app/features/profile/presentation/view/widgets/info_section.dart';
import 'package:resturant_app/features/profile/presentation/view/widgets/setting_section.dart';
import 'package:resturant_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(AuthServicess()),
      child: const ProfileScreenBody(),
    );
  }
}

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // Handle global profile state changes
          if (state is ProfileFailure) {
            showSnakBarFaluire(context, state.message.userFriendlyMessage);
          } else if (state is ProfileLogoutSuccess) {
            showSnakBarSuccess(context, 'Logged out successfully');
          } else if (state is ProfileRefreshSuccess) {
            showSnakBarSuccess(context, 'Profile refreshed');
          }
        },
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<ProfileCubit>().refreshProfile();
            },
            child: SingleChildScrollView(
              physics:
                  const AlwaysScrollableScrollPhysics(), // Enable pull-to-refresh
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Header
                    _buildProfileHeader(context),
                    const SizedBox(height: 20),

                    // Info Section
                    const InfoSection(),
                    const SizedBox(height: 40),

                    // Settings Section
                    const SettingsSection(),

                    // Additional spacing for bottom padding
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: state is ProfileLoading
                        ? null
                        : () => context.read<ProfileCubit>().refreshProfile(),
                    icon: AnimatedRotation(
                      turns: state is ProfileLoading ? 1 : 0,
                      duration: const Duration(seconds: 1),
                      child: Icon(
                        Icons.refresh,
                        color: state is ProfileLoading
                            ? Colors.grey
                            : Colors.blue,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withValues(alpha: 0.3),
                  Colors.blue,
                  Colors.blue.withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}
