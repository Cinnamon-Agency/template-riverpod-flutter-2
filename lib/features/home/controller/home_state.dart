import 'package:equatable/equatable.dart';

enum SelectedHomePage {
  trips,
  friends,
  profile,
}

class HomeState extends Equatable {
  final SelectedHomePage page;
  const HomeState({
    required this.page,
  });

  @override
  List<Object?> get props => [page];
}
