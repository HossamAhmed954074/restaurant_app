import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/firebase_faliure.dart';
import '../../../../core/services/auth_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authServices) : super(AuthInitial());

  final AuthServicess authServices;

  /// Safely emit state only if cubit is not closed
  void _safeEmit(AuthState state) {
    if (!isClosed) {
      emit(state);
    } else {
      log(
        'Attempted to emit state after cubit was closed: $state',
        name: 'AuthCubit',
      );
    }
  }

  /// Register a new user with email, password and name
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    if (isClosed) return;

    _safeEmit(AuthLoading());

    try {
      log('Attempting to register user: $email', name: 'AuthCubit');

      await authServices.registerUser(
        email: email,
        password: password,
        name: name,
      );

      log('User registration successful', name: 'AuthCubit');
      _safeEmit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      log(
        'Firebase auth error during registration: ${e.code}',
        name: 'AuthCubit',
      );
      _safeEmit(AuthFailure(FirebaseFailure.fromFirebaseAuth(e)));
    } catch (e) {
      log('Unexpected error during registration: $e', name: 'AuthCubit');
      _safeEmit(
        AuthFailure(FirebaseFailure.generic('Registration failed: $e')),
      );
    }
  }

  /// Log in user with email and password
  Future<void> logIn({required String email, required String password}) async {
    if (isClosed) return;

    _safeEmit(AuthLoading());

    try {
      log('Attempting to log in user: $email', name: 'AuthCubit');

      await authServices.loginUser(email: email, password: password);

      log('User login successful', name: 'AuthCubit');
      _safeEmit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      log('Firebase auth error during login: ${e.code}', name: 'AuthCubit');
      _safeEmit(AuthFailure(FirebaseFailure.fromFirebaseAuth(e)));
    } catch (e) {
      log('Unexpected error during login: $e', name: 'AuthCubit');
      _safeEmit(AuthFailure(FirebaseFailure.generic('Login failed: $e')));
    }
  }

  /// Reset password for the given email
  Future<void> resetPassword({required String email}) async {
    if (isClosed) return;

    _safeEmit(AuthLoading());

    try {
      log('Attempting to reset password for: $email', name: 'AuthCubit');

      await authServices.resetPassword(email);

      log('Password reset email sent successfully', name: 'AuthCubit');
      _safeEmit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      log(
        'Firebase auth error during password reset: ${e.code}',
        name: 'AuthCubit',
      );
      _safeEmit(AuthFailure(FirebaseFailure.fromFirebaseAuth(e)));
    } catch (e) {
      log('Unexpected error during password reset: $e', name: 'AuthCubit');
      _safeEmit(
        AuthFailure(FirebaseFailure.generic('Password reset failed: $e')),
      );
    }
  }

  /// Sign out current user
  Future<void> signOut() async {
    if (isClosed) return;

    try {
      log('Attempting to sign out user', name: 'AuthCubit');

      await authServices.signOut();

      log('User signed out successfully', name: 'AuthCubit');
      _safeEmit(AuthInitial());
    } catch (e) {
      log('Error during sign out: $e', name: 'AuthCubit');
      _safeEmit(AuthFailure(FirebaseFailure.generic('Sign out failed: $e')));
    }
  }

  @override
  Future<void> close() {
    log('AuthCubit is being closed', name: 'AuthCubit');
    return super.close();
  }
}
