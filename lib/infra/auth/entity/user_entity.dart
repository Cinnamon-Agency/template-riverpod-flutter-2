import 'package:equatable/equatable.dart';

// Using Equatable on this entity because it is used in a stream
class UserEntity extends Equatable {
  final String uid;
  final String jwt;
  final bool isAnonymous;

  const UserEntity({
    required this.uid,
    required this.jwt,
    required this.isAnonymous,
  });

  @override
  List<Object?> get props => [uid, jwt, isAnonymous];
}
