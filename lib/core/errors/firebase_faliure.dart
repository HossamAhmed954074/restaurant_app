class FirebaseFaliure {
  final String message;

  FirebaseFaliure(this.message);

  faliure() {
    switch (message) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'user-not-found':
        return 'There is no user record corresponding to this identifier.';
      case 'user-disabled':
        return 'The user account has been disabled by an administrator.';
      case 'too-many-requests':
        return 'We have blocked all requests from this device due to unusual activity. Try again later.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication.';
      case 'network-request-failed':
        return 'A network error has occurred.';
      default:
        return 'Something went wrong.';
    }
  }
}
