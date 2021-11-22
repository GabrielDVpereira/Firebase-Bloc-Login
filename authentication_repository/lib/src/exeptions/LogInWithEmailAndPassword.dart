class LogInWithEmailAndPasswordFailure implements Exception {
  final String message;

  const LogInWithEmailAndPasswordFailure(
      [this.message = 'An unknown exception has occured.']);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted');
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
            'this user has been disabled. Please contact support for help.');
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
            'Email is not found, please create an account');
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
            'Incorrect password, please try agai');
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}
