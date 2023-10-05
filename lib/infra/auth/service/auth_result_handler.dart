sealed class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}

class EmailAlreadyExistsException extends AuthException {
  EmailAlreadyExistsException() : super("Email is already in use.");
}

class WrongPasswordException extends AuthException {
  WrongPasswordException() : super("Wrong password.");
}

class WeakPasswordException extends AuthException {
  WeakPasswordException() : super("Password is too weak.");
}

class UserNotFoundException extends AuthException {
  UserNotFoundException() : super("User not found.");
}

class InvalidEmailException extends AuthException {
  InvalidEmailException() : super("Invalid email.");
}

class InvalidLoginCredentialsException extends AuthException {
  InvalidLoginCredentialsException() : super("Invalid login credentials.");
}

class OperationNotAllowedException extends AuthException {
  OperationNotAllowedException() : super("Operation not allowed.");
}

class TooManyRequestsException extends AuthException {
  TooManyRequestsException() : super("Too many requests.");
}

class UndefinedAuthException extends AuthException {
  UndefinedAuthException() : super("Undefined authentication error.");
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
