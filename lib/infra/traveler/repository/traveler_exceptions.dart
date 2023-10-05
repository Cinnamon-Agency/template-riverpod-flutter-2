sealed class TravelerException implements Exception {
  final String message;

  TravelerException(this.message);
}

class UsernameTakenException extends TravelerException {
  UsernameTakenException() : super("Username is already in use.");
}

class TravelerExistsException extends TravelerException {
  TravelerExistsException() : super("Traveler already exists.");
}

class TravelerNotFoundException  extends TravelerException {
TravelerNotFoundException() : super("Traveler not found.");
}