import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:flutter/material.dart';

sealed class TravelerException implements Exception {
  final String message;

  TravelerException(this.message);

  String localizedMessage(BuildContext context);
}

class UsernameTakenException extends TravelerException {
  UsernameTakenException() : super("Username is already in use.");

  @override
  String localizedMessage(BuildContext context) {
    return context.localization.usernameAlreadyInUse;
  }
}

class TravelerExistsException extends TravelerException {
  TravelerExistsException() : super("Traveler already exists.");

  @override
  String localizedMessage(BuildContext context) {
    return context.localization.travelerAlreadyExists;
  }
}

class TravelerNotFoundException extends TravelerException {
  TravelerNotFoundException() : super("Traveler not found.");

  @override
  String localizedMessage(BuildContext context) {
    return context.localization.travelerNotFound;
  }
}
