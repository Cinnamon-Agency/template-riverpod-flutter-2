import 'package:equatable/equatable.dart';

class AccountState extends Equatable {
  const AccountState({this.loading = false, this.notificationsFlag = false});

  final bool loading;
  final bool notificationsFlag;

  @override
  List<Object?> get props => <dynamic>[loading, notificationsFlag];
}
