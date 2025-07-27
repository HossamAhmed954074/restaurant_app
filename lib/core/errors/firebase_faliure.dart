import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Custom exception class for handling Firebase-related errors
/// Provides user-friendly error messages for common Firebase authentication and Firestore errors
class FirebaseFailure implements Exception {
  /// The original Firebase error code
  final String code;

  /// The original Firebase error message
  final String originalMessage;

  /// Creates a FirebaseFailure with the given error code and message
  const FirebaseFailure({required this.code, required this.originalMessage});

  /// Factory constructor to create FirebaseFailure from FirebaseAuthException
  factory FirebaseFailure.fromFirebaseAuth(FirebaseAuthException exception) {
    return FirebaseFailure(
      code: exception.code,
      originalMessage: exception.message ?? 'Unknown Firebase Auth error',
    );
  }

  /// Factory constructor to create FirebaseFailure from FirebaseException
  factory FirebaseFailure.fromFirebaseException(FirebaseException exception) {
    return FirebaseFailure(
      code: exception.code,
      originalMessage: exception.message ?? 'Unknown Firebase error',
    );
  }

  /// Factory constructor for generic errors
  factory FirebaseFailure.generic(String message) {
    return FirebaseFailure(code: 'generic-error', originalMessage: message);
  }

  /// Returns a user-friendly error message based on the Firebase error code
  String get userFriendlyMessage {
    switch (code) {
      // Authentication errors
      case 'weak-password':
        return 'The password provided is too weak. Please use at least 6 characters.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'invalid-email':
        return 'The email address is not valid. Please check and try again.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'user-not-found':
        return 'No account found with this email address.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled. Please contact support.';
      case 'requires-recent-login':
        return 'Please sign in again to complete this action.';
      case 'invalid-credential':
        return 'The provided credentials are invalid. Please try again.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different sign-in method.';
      case 'invalid-verification-code':
        return 'The verification code is invalid. Please try again.';
      case 'invalid-verification-id':
        return 'The verification session has expired. Please try again.';
      case 'user-mismatch':
        return 'The credentials do not match the current user.';
      case 'credential-already-in-use':
        return 'This credential is already linked to another account.';

      // Network and connectivity errors
      case 'network-request-failed':
        return 'Network error. Please check your connection and try again.';
      case 'timeout':
        return 'Request timed out. Please try again.';

      // Firestore errors
      case 'permission-denied':
        return 'You do not have permission to perform this action.';
      case 'not-found':
        return 'The requested data was not found.';
      case 'already-exists':
        return 'The data already exists.';
      case 'resource-exhausted':
        return 'Service temporarily unavailable. Please try again later.';
      case 'failed-precondition':
        return 'The operation cannot be completed in the current state.';
      case 'out-of-range':
        return 'The requested data is out of range.';
      case 'unimplemented':
        return 'This feature is not yet implemented.';
      case 'internal':
        return 'An internal error occurred. Please try again.';
      case 'unavailable':
        return 'Service is currently unavailable. Please try again later.';
      case 'data-loss':
        return 'Data loss occurred. Please contact support.';
      case 'unauthenticated':
        return 'Authentication required. Please sign in.';

      // Generic errors
      case 'generic-error':
        return originalMessage.isNotEmpty
            ? originalMessage
            : 'An unexpected error occurred.';

      default:
        return 'Something went wrong. Please try again.';
    }
  }

  /// Returns a developer-friendly error message with more technical details
  String get developerMessage {
    return 'Firebase Error [$code]: $originalMessage';
  }

  /// Checks if the error is related to authentication
  bool get isAuthError {
    const authErrorCodes = {
      'weak-password',
      'email-already-in-use',
      'invalid-email',
      'wrong-password',
      'user-not-found',
      'user-disabled',
      'too-many-requests',
      'operation-not-allowed',
      'requires-recent-login',
      'invalid-credential',
      'account-exists-with-different-credential',
      'invalid-verification-code',
      'invalid-verification-id',
      'user-mismatch',
      'credential-already-in-use',
      'unauthenticated',
    };
    return authErrorCodes.contains(code);
  }

  /// Checks if the error is related to network connectivity
  bool get isNetworkError {
    const networkErrorCodes = {
      'network-request-failed',
      'timeout',
      'unavailable',
    };
    return networkErrorCodes.contains(code);
  }

  /// Checks if the error is related to permissions
  bool get isPermissionError {
    const permissionErrorCodes = {'permission-denied', 'unauthenticated'};
    return permissionErrorCodes.contains(code);
  }

  @override
  String toString() => userFriendlyMessage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FirebaseFailure &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          originalMessage == other.originalMessage;

  @override
  int get hashCode => code.hashCode ^ originalMessage.hashCode;
}
