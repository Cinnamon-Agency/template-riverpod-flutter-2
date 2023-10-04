import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final bool allFieldsValid;
  final bool isLoading;

  const SignupState({
    this.allFieldsValid = false,
    this.isLoading = false,
  });

  SignupState copyWith({
    bool? allFieldsValid,
    bool? loading,
  }) {
    return SignupState(
      allFieldsValid: allFieldsValid ?? this.allFieldsValid,
      isLoading: loading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        allFieldsValid,
        isLoading,
      ];
}
