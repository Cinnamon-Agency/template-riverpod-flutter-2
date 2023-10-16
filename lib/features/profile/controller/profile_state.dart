import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  const ProfileState({this.loading = false, this.notificationsFlag = false});

  final bool loading;
  final bool notificationsFlag;

  @override
  List<Object?> get props => <dynamic>[loading, notificationsFlag];
}
