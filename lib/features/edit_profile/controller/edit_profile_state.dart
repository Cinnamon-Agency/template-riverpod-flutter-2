import 'package:equatable/equatable.dart';

class EditProfileState extends Equatable {
  const EditProfileState({this.loading = false});

  final bool loading;

  @override
  List<Object?> get props => <dynamic>[loading];
}
