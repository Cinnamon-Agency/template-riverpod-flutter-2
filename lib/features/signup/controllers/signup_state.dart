import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final bool allFieldsValid;

  const SignupState({
    this.allFieldsValid = false,
  });

  SignupState copyWith({
    bool? allFieldsValid,
  }) =>
      SignupState(
        allFieldsValid: allFieldsValid ?? this.allFieldsValid,
      );

  @override
  List<Object?> get props => [
        allFieldsValid,
      ];
}
