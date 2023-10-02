class SignupState {
  final bool allFieldsValid;

  SignupState({
    this.allFieldsValid = false,
  });

  SignupState copyWith({
    bool? allFieldsValid,
  }) =>
      SignupState(
        allFieldsValid: allFieldsValid ?? this.allFieldsValid,
      );
}
