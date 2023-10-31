import 'package:equatable/equatable.dart';

class AccountState extends Equatable {
  const AccountState({this.notificationsFlag = false});

  final bool notificationsFlag;

  @override
  List<Object?> get props => <dynamic>[notificationsFlag];
}
