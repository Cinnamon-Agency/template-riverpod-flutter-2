import '../constants/enums.dart';

/// Helper class for handling auth results.
class AuthResultHandler {
  /// Parses exception code from [e] and returns the correct `AuthResultStatus`.
  static AuthResultStatus handleException(e) {
    switch (e.code) {
      case "email-already-in-use":
        return AuthResultStatus.emailAlreadyExists;
      case "ERROR_WRONG_PASSWORD":
        return AuthResultStatus.wrongPassword;
      case "weak-password":
        return AuthResultStatus.weakPassword;
      case "ERROR_USER_NOT_FOUND":
        return AuthResultStatus.userNotFound;
      case "invalid-email":
        return AuthResultStatus.invalidEmail;
      case "INVALID_LOGIN_CREDENTIALS":
        return AuthResultStatus.invalidLoginCredentials;
      case "operation-not-allowed":
        return AuthResultStatus.operationNotAllowed;
      case "ERROR_TOO_MANY_REQUESTS":
        return AuthResultStatus.tooManyRequests;
      default:
        return AuthResultStatus.undefined;
    }
  }
}

extension AuthResultStatusExtension on AuthResultStatus {
  /// Returns a human-readable error message for a status.
  String getStatusMessage() {
    switch (this) {
      case AuthResultStatus.successful:
        return "Success";
      case AuthResultStatus.emailAlreadyExists:
        return "User with this email already exists";
      case AuthResultStatus.wrongPassword:
        return "Incorrect password";
      case AuthResultStatus.weakPassword:
        return "Weak password";
      case AuthResultStatus.userNotFound:
        return "Could not find a user with this email";
      case AuthResultStatus.invalidEmail:
        return "Invalid email";
      case AuthResultStatus.invalidLoginCredentials:
        return "Invalid login credentials";
      case AuthResultStatus.operationNotAllowed:
        return "Operation not allowed";
      case AuthResultStatus.tooManyRequests:
        return "Too many requests. Try again later";
      case AuthResultStatus.undefined:
        return "An unexpected error has occured. Try again later";
    }
  }
}
