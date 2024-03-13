import 'package:equatable/equatable.dart';

final class SplashState extends Equatable {
  final bool isAnon;

  const SplashState(this.isAnon);

  @override
  List<Object?> get props => [
        isAnon,
      ];
}
