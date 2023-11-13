import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:flutter/material.dart';

sealed class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  String localizedMessage(BuildContext context);
}

class EmailAlreadyExistsException extends AuthException {
  EmailAlreadyExistsException() : super("Email is already in use.");

  @override
  String localizedMessage(BuildContext context) {
    return context.L.emailAlreadyInUse;
  }
}

class WrongPasswordException extends AuthException {
  WrongPasswordException() : super("Wrong password.");

  @override
  String localizedMessage(BuildContext context) {
    return context.L.wrongPassword;
  }
}

class WeakPasswordException extends AuthException {
  WeakPasswordException() : super("Password is too weak.");

  @override
  String localizedMessage(BuildContext context) {
    return context.L.passwordTooWeak;
  }
}

class UserNotFoundException extends AuthException {
  UserNotFoundException() : super("User not found.");

  @override
  String localizedMessage(BuildContext context) {
    return context.L.userNotFound;
  }
}

class InvalidEmailException extends AuthException {
  InvalidEmailException() : super("Invalid email.");

  @override
  String localizedMessage(BuildContext context) {
    return context.L.invalidEmail;
  }
}

class InvalidLoginCredentialsException extends AuthException {
  InvalidLoginCredentialsException() : super("Invalid login credentials.");

  @override
  String localizedMessage(BuildContext context) {
    return context.L.invalidLoginCredentials;
  }
}

class OperationNotAllowedException extends AuthException {
  OperationNotAllowedException() : super("Operation not allowed.");

  @override
  String localizedMessage(BuildContext context) {
    return context.L.operationNotAllowed;
  }
}

class TooManyRequestsException extends AuthException {
  TooManyRequestsException() : super("Too many requests.");

  @override
  String localizedMessage(BuildContext context) {
    return context.L.tooManyRequests;
  }
}

class UndefinedAuthException extends AuthException {
  UndefinedAuthException() : super("Undefined authentication error.");

  @override
  String localizedMessage(BuildContext context) {
    return context.L.undefinedAuthError;
  }
}

class AuthResultHandler {
  static AuthException handleException(dynamic e) {
    switch (e.code) {
      case "email-already-in-use":
        return EmailAlreadyExistsException();
      case "ERROR_WRONG_PASSWORD":
        return WrongPasswordException();
      case "weak-password":
        return WeakPasswordException();
      case "ERROR_USER_NOT_FOUND":
        return UserNotFoundException();
      case "invalid-email":
        return InvalidEmailException();
      case "INVALID_LOGIN_CREDENTIALS":
        return InvalidLoginCredentialsException();
      case "operation-not-allowed":
        return OperationNotAllowedException();
      case "ERROR_TOO_MANY_REQUESTS":
        return TooManyRequestsException();
      default:
        return UndefinedAuthException();
    }
  }
}

// extension AuthResultStatusExtension on AuthResultStatus {
//   /// Returns a human-readable error message for a status.
//   String getStatusMessage() {
//     switch (this) {
//       case AuthResultStatus.successful:
//         return "Success";
//       case AuthResultStatus.emailAlreadyExists:
//         return "User with this email already exists";
//       case AuthResultStatus.wrongPassword:
//         return "Incorrect password";
//       case AuthResultStatus.weakPassword:
//         return "Weak password";
//       case AuthResultStatus.userNotFound:
//         return "Could not find a user with this email";
//       case AuthResultStatus.invalidEmail:
//         return "Invalid email";
//       case AuthResultStatus.invalidLoginCredentials:
//         return "Invalid login credentials";
//       case AuthResultStatus.operationNotAllowed:
//         return "Operation not allowed";
//       case AuthResultStatus.tooManyRequests:
//         return "Too many requests. Try again later";
//       case AuthResultStatus.undefined:
//         return "An unexpected error has occured. Try again later";
//     }
//   }
// }
