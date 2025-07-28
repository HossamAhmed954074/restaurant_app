import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();

        return Container(
          padding: const EdgeInsets.all(24),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image with loading indicator
              _buildProfileImage(cubit, state),
              const SizedBox(height: 20),

              // User Name with shimmer effect while loading
              _buildUserName(cubit, state),
              const SizedBox(height: 8),

              // User Email
              _buildUserEmail(cubit, state),
              const SizedBox(height: 16),

              // User Status Badge
              _buildUserStatusBadge(cubit),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileImage(ProfileCubit cubit, ProfileState state) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blue.withValues(alpha: 0.3), width: 3),
          ),
          child: CircleAvatar(
            radius: 65,
            backgroundColor: Colors.grey[100],
            child: CachedNetworkImage(
              imageUrl: cubit.userInfo.photoURL ?? '',
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade200, Colors.blue.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
          ),
        ),

        // Online status indicator
        if (cubit.isAuthenticated)
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(Icons.check, size: 12, color: Colors.white),
            ),
          ),
      ],
    );
  }

  Widget _buildUserName(ProfileCubit cubit, ProfileState state) {
    final name = cubit.currentUser?.displayName ?? 'No Name';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          letterSpacing: 0.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildUserEmail(ProfileCubit cubit, ProfileState state) {
    final email = cubit.currentUser?.email ?? 'No Email';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.email_outlined, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            email,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserStatusBadge(ProfileCubit cubit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: cubit.isAuthenticated
              ? [Colors.green.shade400, Colors.green.shade600]
              : [Colors.red.shade400, Colors.red.shade600],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            cubit.isAuthenticated ? Icons.verified_user : Icons.error_outline,
            size: 16,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            cubit.isAuthenticated ? 'Verified Account' : 'Not Authenticated',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
