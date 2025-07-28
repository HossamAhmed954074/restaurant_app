import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:resturant_app/core/errors/firebase_faliure.dart';
import 'package:resturant_app/core/services/auth_services.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.authService) : super(ProfileInitial());

  final AuthServicess authService;

  /// Safely emit state only if cubit is not closed
  void _safeEmit(ProfileState state) {
    if (!isClosed) {
      emit(state);
    } else {
      log(
        'Attempted to emit state after cubit was closed: $state',
        name: 'ProfileCubit',
      );
    }
  }

  /// Get current user information
  User? get currentUser => authService.currentUser;

  /// Get current user info including profile data
  UserInfo get userInfo => authService.userInfo;

  /// Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  /// Sign out the current user
  Future<void> logOut() async {
    if (isClosed) return;

    try {
      log('Attempting to sign out user', name: 'ProfileCubit');
      _safeEmit(ProfileLoading());

      await authService.signOut();

      log('User signed out successfully', name: 'ProfileCubit');
      _safeEmit(ProfileLogoutSuccess());
    } catch (e) {
      log('Error during sign out: $e', name: 'ProfileCubit');
      _safeEmit(ProfileFailure(FirebaseFailure.generic('Sign out failed: $e')));
    }
  }

  /// Reset password with current password validation
  Future<void> resetPasswordWithEmail({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    if (isClosed) return;

    _safeEmit(ProfileResetPasswordLoading());

    try {
      log('Attempting to reset password for: $email', name: 'ProfileCubit');

      await authService.resetPasswordFromCurrentPassword(
        email: email,
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      log('Password reset successful', name: 'ProfileCubit');
      _safeEmit(ProfileResetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      log(
        'Firebase auth error during password reset: ${e.code}',
        name: 'ProfileCubit',
      );
      _safeEmit(
        ProfileResetPasswordFailure(FirebaseFailure.fromFirebaseAuth(e)),
      );
    } catch (e) {
      log('Unexpected error during password reset: $e', name: 'ProfileCubit');
      _safeEmit(
        ProfileResetPasswordFailure(
          FirebaseFailure.generic('Password reset failed: $e'),
        ),
      );
    }
  }

  /// Update user display name
  Future<void> resetUserName({required String newUserName}) async {
    if (isClosed) return;

    _safeEmit(ProfileResetUserNameLoading());

    try {
      log(
        'Attempting to update username to: $newUserName',
        name: 'ProfileCubit',
      );

      await authService.updateUserName(name: newUserName);

      log('Username updated successfully', name: 'ProfileCubit');
      _safeEmit(ProfileResetUserNameSuccess());
    } on FirebaseAuthException catch (e) {
      log(
        'Firebase auth error during username update: ${e.code}',
        name: 'ProfileCubit',
      );
      _safeEmit(
        ProfileResetUserNameFailure(FirebaseFailure.fromFirebaseAuth(e)),
      );
    } catch (e) {
      log('Unexpected error during username update: $e', name: 'ProfileCubit');
      _safeEmit(
        ProfileResetUserNameFailure(
          FirebaseFailure.generic('Username update failed: $e'),
        ),
      );
    }
  }

  /// Delete user account permanently
  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    if (isClosed) return;

    _safeEmit(ProfileDeleteAccountLoading());

    try {
      log('Attempting to delete account for: $email', name: 'ProfileCubit');

      await authService.deleteAccount(email: email, password: password);

      log('Account deleted successfully', name: 'ProfileCubit');
      _safeEmit(ProfileDeleteAccountSuccess());
    } on FirebaseAuthException catch (e) {
      log(
        'Firebase auth error during account deletion: ${e.code}',
        name: 'ProfileCubit',
      );
      _safeEmit(
        ProfileDeleteAccountFailure(FirebaseFailure.fromFirebaseAuth(e)),
      );
    } catch (e) {
      log('Unexpected error during account deletion: $e', name: 'ProfileCubit');
      _safeEmit(
        ProfileDeleteAccountFailure(
          FirebaseFailure.generic('Account deletion failed: $e'),
        ),
      );
    }
  }

  /// Refresh user profile data
  Future<void> refreshProfile() async {
    if (isClosed) return;

    try {
      log('Refreshing user profile', name: 'ProfileCubit');
      _safeEmit(ProfileLoading());

      // Reload current user data
      await currentUser?.reload();

      log('Profile refreshed successfully', name: 'ProfileCubit');
      _safeEmit(ProfileRefreshSuccess());
    } catch (e) {
      log('Error refreshing profile: $e', name: 'ProfileCubit');
      _safeEmit(
        ProfileFailure(FirebaseFailure.generic('Profile refresh failed: $e')),
      );
    }
  }

  /// Reset cubit to initial state
  void resetState() {
    if (!isClosed) {
      _safeEmit(ProfileInitial());
    }
  }

  @override
  Future<void> close() {
    log('ProfileCubit is being closed', name: 'ProfileCubit');
    return super.close();
  }
}
