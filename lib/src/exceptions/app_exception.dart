/// base class for all client-side errors
/// a sealed class allows to define all possible recoverable exceptions
sealed class AppException implements Exception {
  AppException({required this.code, required this.message});
  final String code;
  final String message;

  @override
  String toString() => message;
}

/// following: implementations of the possible exceptions
/// that can occur and should fail gracefully by showing the user a dialog
class WeakPasswordException extends AppException {
  WeakPasswordException()
      : super(
          code: 'weak-password',
          message: 'Password is too weak',
        );
}

class UserNotFoundException extends AppException {
  UserNotFoundException()
      : super(
          code: 'user-not-found',
          message: 'User was not found',
        );
}
