import 'package:equatable/equatable.dart';

class EditProfileState extends Equatable {
  const EditProfileState(
      {this.loading = false, this.username = '', this.isUsernameValid = false});

  final bool loading;

  final String username;

  final bool isUsernameValid;

  @override
  List<Object?> get props => <dynamic>[loading, username, isUsernameValid];

  EditProfileState copyWith(
          {bool? loading, String? username, bool? isUsernameValid}) =>
      EditProfileState(
        loading: loading ?? this.loading,
        username: username ?? this.username,
        isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      );
}
