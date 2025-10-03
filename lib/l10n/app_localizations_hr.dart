// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get onboardingShare =>
      'Jednostavno podijelite svoje uzbudljive planove puta. Šaljite uvid u svoje avanture kako bi svi bili u tijeku s njima.';

  @override
  String get onboardingCollaborate =>
      'Učinite planiranje lakim surađujući s drugima. Radite zajedno kako biste stvorili savršeni plan.';

  @override
  String get onboardingTravel =>
      'Sada kada su vaši planovi postavljeni, uronite u radost putovanja.';

  @override
  String get getStarted => 'Započni';

  @override
  String get startYourJourney => 'Započni svoje\nTripFinder putovanje!';

  @override
  String get createAccountToPlan =>
      'Izradi račun za početak planiranja svojih putovanja.';

  @override
  String get or => 'Ili';

  @override
  String get continueWithApple => 'Nastavi s Appleom';

  @override
  String get continueWithGoogle => 'Nastavi s Googleom';

  @override
  String get continueWithEmail => 'Nastavi s e-poštom';

  @override
  String get signUp => 'Prijavi se';

  @override
  String get signUpForAccount => 'Napravi svoj TripFinder račun';

  @override
  String get username => 'Korisničko ime';

  @override
  String get email => 'E-pošta';

  @override
  String get password => 'Lozinka';

  @override
  String get confirmPassword => 'Potvrdi lozinku';

  @override
  String get passwordRequirements =>
      'Lozinka treba imati najmanje 8 znakova i sadržavati barem jedno veliko slovo, jedno malo slovo i jednu znamenku.';

  @override
  String get logIn => 'Prijava';

  @override
  String get logInToAccount => 'Prijavi se u svoj TripFinder račun';

  @override
  String get logOut => 'Odjava';

  @override
  String get logOutConfirmation => 'Jeste li sigurni da se želite odjaviti?';

  @override
  String get logOutFailed => 'Odjava nije uspjela. Pokušajte ponovno.';

  @override
  String get trips => 'Putovanja';

  @override
  String get friends => 'Prijatelji';

  @override
  String get account => 'Račun';

  @override
  String get more => 'Više';

  @override
  String get edit => 'Uredi';

  @override
  String get back => 'Natrag';

  @override
  String get planNewTrip => 'Planiraj novo putovanje';

  @override
  String get upcomingTrips => 'Nadolazeća putovanja';

  @override
  String get pastTrips => 'Prošla putovanja';

  @override
  String get currentlyNotTravelling => 'Trenutno ne putujete';

  @override
  String get noUpcomingTrips => 'Nemate nadolazećih putovanja';

  @override
  String get noPastTrips => 'Nemate prošlih putovanja';

  @override
  String get noTripsPlaceholder =>
      'Nemate nijedno putovanje. Isplanirajte jedno!';

  @override
  String get current => 'Trenutno';

  @override
  String get next => 'Sljedeće';

  @override
  String get details => 'Detalji';

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
      other: '$countString lokacija',
      two: '2 lokacije',
      one: '1 lokacija',
      zero: 'Bez lokacija',
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
      other: '$countString putnika',
      one: '1 putnik',
      zero: 'Bez putnika',
    );
    return '$_temp0';
  }

  @override
  String get tripLocations => 'Lokacije putovanja';

  @override
  String get noTripLocations =>
      'Niste dodali nikakve lokacije za ovo putovanje.';

  @override
  String get startTrip => 'Započni putovanje';

  @override
  String get endTrip => 'Završi putovanje';

  @override
  String get moveToNext => 'Idi na sljedeće';

  @override
  String get addTripLocationsBeforeStarting =>
      'Dodajte lokacije prije početka putovanja';

  @override
  String get startDate => 'Početni datum';

  @override
  String get endDate => 'Završni datum';

  @override
  String get description => 'Opis';

  @override
  String get createANewTrip => 'Kreiraj novo putovanje';

  @override
  String get editTrip => 'Editiraj putovanje';

  @override
  String get name => 'Ime';

  @override
  String get coTravelers => 'Suputnici';

  @override
  String get locations => 'Lokacije';

  @override
  String get thisFieldIsRequired => 'Ovo polje je obavezno.';

  @override
  String get startDateMustBeBeforeEndDate =>
      'Početni datum mora biti prije završnog datuma';

  @override
  String get endDateMustBeAfterStartDate =>
      'Završni datum mora biti nakon početnog datuma';

  @override
  String get save => 'Spremi';

  @override
  String get create => 'Kreiraj';

  @override
  String get reset => 'Poništi';

  @override
  String get usernameNA => 'Korisničko ime N/A';

  @override
  String get editProfile => 'Uredi profil';

  @override
  String get settings => 'Postavke';

  @override
  String get pushNotifications => 'Push obavijesti';

  @override
  String get submitChanges => 'Potvrdi promjene';

  @override
  String get failedValueChange =>
      'Promjena vrijednosti nije uspjela. Pokušajte ponovno.';

  @override
  String get deleteAccount => 'Izbriši račun';

  @override
  String get deleteAccountConfirmation =>
      'Jeste li sigurni da želite izbrisati račun?';

  @override
  String get deleteAccountMessage =>
      'Brisanje računa je nepovratno, izgubit ćete sve podatke povezane s računom.';

  @override
  String get ok => 'U redu';

  @override
  String get success => 'Uspjeh';

  @override
  String get error => 'Greška';

  @override
  String get cancel => 'Odustani';

  @override
  String get confirm => 'Potvrdi';

  @override
  String get usernameAlreadyInUse => 'Korisničko ime se već koristi.';

  @override
  String get travelerAlreadyExists => 'Putnik već postoji.';

  @override
  String get travelerNotFound => 'Putnik nije pronađen.';

  @override
  String get emailAlreadyInUse => 'E-pošta se već koristi.';

  @override
  String get wrongPassword => 'Pogrešna lozinka.';

  @override
  String get passwordTooWeak => 'Lozinka je preslaba.';

  @override
  String get userNotFound => 'Korisnik nije pronađen.';

  @override
  String get invalidEmail => 'Neispravna e-pošta.';

  @override
  String get invalidLoginCredentials => 'Neispravni podaci za prijavu.';

  @override
  String get operationNotAllowed => 'Operacija nije dopuštena.';

  @override
  String get tooManyRequests => 'Previše zahtjeva.';

  @override
  String get undefinedAuthError => 'Nedefinirana pogreška autentikacije.';

  @override
  String get currentLanguage => 'Trenutni jezik: ';

  @override
  String get changeLanguage => 'Promijeni jezik: ';

  @override
  String get developedBy => 'Razvio';

  @override
  String get inZagreb => 'u Zagrebu, Hrvatska';
}
