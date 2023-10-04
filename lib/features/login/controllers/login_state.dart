import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool allFieldsValid;

  const LoginState({
    this.allFieldsValid = false,
  });

  LoginState copyWith({
    bool? allFieldsValid,
  }) =>
      LoginState(
        allFieldsValid: allFieldsValid ?? this.allFieldsValid,
      );

  @override
  List<Object?> get props => [
        allFieldsValid,
      ];
}
