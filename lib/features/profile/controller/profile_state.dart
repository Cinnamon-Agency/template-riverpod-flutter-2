import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  const ProfileState({this.loading = false});

  final bool loading;

  @override
  List<Object?> get props => <dynamic>[loading];
}
