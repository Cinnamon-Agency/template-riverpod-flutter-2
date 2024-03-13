import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool allFieldsValid;
  final bool isLoading;
  const LoginState({
    this.allFieldsValid = false,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        allFieldsValid,
        isLoading,
      ];

  LoginState copyWith({
    bool? allFieldsValid,
    bool? isLoading,
  }) {
    return LoginState(
      allFieldsValid: allFieldsValid ?? this.allFieldsValid,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
