import 'package:equatable/equatable.dart';

class EditProfileState extends Equatable {
  const EditProfileState({this.username = '', this.isUsernameValid = false});

  final String username;

  final bool isUsernameValid;

  @override
  List<Object?> get props => <dynamic>[username, isUsernameValid];

  EditProfileState copyWith({String? username, bool? isUsernameValid}) =>
      EditProfileState(
        username: username ?? this.username,
        isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      );
}
