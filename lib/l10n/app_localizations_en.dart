// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get onboardingShare =>
      'Easily share your exciting travel itineraries. Keep everyone in the loop by sending them a glimpse of your adventures.';

  @override
  String get onboardingCollaborate =>
      'Make planning a breeze by collaborating with others. Work together to create the perfect itinerary.';

  @override
  String get onboardingTravel =>
      'Now that your plans are set, immerse yourself in the joy of the journey.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get startYourJourney => 'Start your\nTripFinder journey!';

  @override
  String get createAccountToPlan =>
      'Create an account to start planning your trips.';

  @override
  String get or => 'Or';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithEmail => 'Continue with email';

  @override
  String get signUp => 'Sign up';

  @override
  String get signUpForAccount => 'Sign up for a TripFinder account';

  @override
  String get username => 'Username';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get passwordRequirements =>
      'Password should be at least 8 characters long, and contain at least one uppercase letter, one lowercase letter, and one digit.';

  @override
  String get logIn => 'Log in';

  @override
  String get logInToAccount => 'Log in to your TripFinder account';

  @override
  String get logOut => 'Log out';

  @override
  String get logOutConfirmation => 'Are you sure you want to log out?';

  @override
  String get logOutFailed => 'Log out failed. Please try again.';

  @override
  String get trips => 'Trips';

  @override
  String get friends => 'Friends';

  @override
  String get account => 'Account';

  @override
  String get more => 'More';

  @override
  String get edit => 'Edit';

  @override
  String get back => 'Back';

  @override
  String get planNewTrip => 'Plan new trip';

  @override
  String get upcomingTrips => 'Upcoming trips';

  @override
  String get pastTrips => 'Past trips';

  @override
  String get currentlyNotTravelling => 'You\'re currently not travelling';

  @override
  String get noUpcomingTrips => 'You don\'t have any upcoming trips';

  @override
  String get noPastTrips => 'You don\'t have any past trips';

  @override
  String get noTripsPlaceholder =>
      'You don\'t have any trips. Go and plan some!';

  @override
  String get current => 'Current';

  @override
  String get next => 'Next';

  @override
  String get details => 'Details';

  @override
  String get minutesShort => 'min';

  @override
  String nLocations(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString locations',
      one: '1 location',
      zero: 'No locations',
    );
    return '$_temp0';
  }

  @override
  String nTravellers(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString travellers',
      one: '1 traveller',
      zero: 'No travellers',
    );
    return '$_temp0';
  }

  @override
  String get tripLocations => 'Trip locations';

  @override
  String get noTripLocations =>
      'You haven\'t added any locations to this trip.';

  @override
  String get startTrip => 'Start trip';

  @override
  String get endTrip => 'End trip';

  @override
  String get moveToNext => 'Move to next';

  @override
  String get addTripLocationsBeforeStarting =>
      'Add locations before starting your trip';

  @override
  String get startDate => 'Start date';

  @override
  String get endDate => 'End date';

  @override
  String get description => 'Description';

  @override
  String get createANewTrip => 'Create a new trip';

  @override
  String get editTrip => 'Edit trip';

  @override
  String get name => 'Name';

  @override
  String get coTravelers => 'Co-travelers';

  @override
  String get locations => 'Locations';

  @override
  String get thisFieldIsRequired => 'This field is required.';

  @override
  String get startDateMustBeBeforeEndDate =>
      'Start date must be before end date';

  @override
  String get endDateMustBeAfterStartDate => 'End date must be after start date';

  @override
  String get save => 'Save';

  @override
  String get create => 'Create';

  @override
  String get reset => 'Reset';

  @override
  String get usernameNA => 'Username N/A';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get settings => 'Settings';

  @override
  String get pushNotifications => 'Push notifications';

  @override
  String get submitChanges => 'Submit changes';

  @override
  String get failedValueChange =>
      'Failed to change the value. Please try again.';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountConfirmation =>
      'Are you sure you want to delete the account?';

  @override
  String get deleteAccountMessage =>
      'Deleting an account is irreversible, you will lose all of your account-related data.';

  @override
  String get ok => 'Ok';

  @override
  String get success => 'Success';

  @override
  String get error => 'Error';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get usernameAlreadyInUse => 'Username is already in use.';

  @override
  String get travelerAlreadyExists => 'Traveler already exists.';

  @override
  String get travelerNotFound => 'Traveler not found.';

  @override
  String get emailAlreadyInUse => 'Email is already in use.';

  @override
  String get wrongPassword => 'Wrong password.';

  @override
  String get passwordTooWeak => 'Password is too weak.';

  @override
  String get userNotFound => 'User not found.';

  @override
  String get invalidEmail => 'Invalid email.';

  @override
  String get invalidLoginCredentials => 'Invalid login credentials.';

  @override
  String get operationNotAllowed => 'Operation not allowed.';

  @override
  String get tooManyRequests => 'Too many requests.';

  @override
  String get undefinedAuthError => 'Undefined authentication error.';

  @override
  String get developedBy => 'Developed by';

  @override
  String get inZagreb => 'in Zagreb, Croatia';
}
