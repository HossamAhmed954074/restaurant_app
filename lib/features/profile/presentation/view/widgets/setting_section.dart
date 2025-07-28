import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:resturant_app/core/router/app_router.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_faluire.dart';
import 'package:resturant_app/core/utils/widgets/show_snak_sucess.dart';
import 'package:resturant_app/features/profile/presentation/view/widgets/alert_dailog_custom.dart';
import 'package:resturant_app/features/profile/presentation/view/widgets/alert_dailog_custom_Delete_account.dart';
import 'package:resturant_app/features/profile/presentation/view/widgets/alert_dailog_custom_user_name.dart';
import 'package:resturant_app/features/profile/presentation/view/widgets/build_setting_opthion.dart';
import 'package:resturant_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // Handle logout success
        if (state is ProfileLogoutSuccess) {
          _handleLogoutSuccess(context);
        }
        // Handle other profile-specific states
        else if (state is ProfileResetPasswordSuccess) {
          showSnakBarSuccess(context, 'Password changed successfully');
        } else if (state is ProfileResetUserNameSuccess) {
          showSnakBarSuccess(context, 'Username updated successfully');
        } else if (state is ProfileDeleteAccountSuccess) {
          showSnakBarSuccess(context, 'Account deleted successfully');
          _handleLogoutSuccess(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Settings Header
            _buildSectionHeader(),
            const SizedBox(height: 20),

            // Settings Options
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                final cubit = context.read<ProfileCubit>();

                if (cubit.isAuthenticated) {
                  return _buildAuthenticatedUserOptions(context);
                } else {
                  return _buildUnauthenticatedMessage();
                }
              },
            ),

            const SizedBox(height: 16),

            // Logout Option
            _buildLogoutOption(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.settings, color: Colors.blue, size: 20),
        ),
        const SizedBox(width: 12),
        const Text(
          "Account Settings",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildAuthenticatedUserOptions(BuildContext context) {
    return Column(
      children: [
        BuildSettingsOption(
          onPressed: () => _showUpdateUsernameDialog(context),
          icon: Icons.edit_outlined,
          text: "Update Username",
          iconColor: Colors.blue,
        ),

        BuildSettingsOption(
          onPressed: () => _showChangePasswordDialog(context),
          icon: Icons.lock_outline,
          text: "Change Password",
          iconColor: Colors.orange,
        ),

        const Divider(height: 32, color: Colors.grey),

        BuildSettingsOption(
          onPressed: () => _showDeleteAccountDialog(context),
          icon: Icons.delete_outline,
          text: "Delete Account",
          iconColor: Colors.red,
        ),
      ],
    );
  }

  Widget _buildUnauthenticatedMessage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.orange.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Please sign in to access account settings',
              style: TextStyle(
                color: Colors.orange.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutOption(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final isLoading = state is ProfileLoading;

        return BuildSettingsOption(
          onPressed: isLoading ? () {} : () => _showLogoutDialog(context),
          icon: isLoading ? Icons.hourglass_empty : Icons.logout,
          text: isLoading ? "Signing out..." : "Sign Out",
          iconColor: isLoading ? Colors.grey : Colors.red,
        );
      },
    );
  }

  void _showUpdateUsernameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<ProfileCubit>(),
        child: const AlertDaialogCustomUpdateUserName(),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<ProfileCubit>(),
        child: const AlertDialogCustomWidget(),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<ProfileCubit>(),
        child: const AlertDaialogCustomDeleteAccount(),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.logout, color: Colors.red.shade600),
            const SizedBox(width: 8),
            const Text('Sign Out'),
          ],
        ),
        content: const Text(
          'Are you sure you want to sign out of your account?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<ProfileCubit>().logOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogoutSuccess(BuildContext context) async {
    try {
      // Clear onboarding preference
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding', false);

      // Navigate to onboarding
      if (context.mounted) {
        context.go(AppRouter.kOnboardingScreen);
      }
    } catch (e) {
      // Handle error silently or show error message
      if (context.mounted) {
        showSnakBarFaluire(context, 'Error during logout navigation');
      }
    }
  }
}
