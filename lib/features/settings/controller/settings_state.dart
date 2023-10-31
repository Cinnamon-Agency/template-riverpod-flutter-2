import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  const SettingsState({this.loading = false});

  final bool loading;

  @override
  List<Object?> get props => <dynamic>[loading];
}
