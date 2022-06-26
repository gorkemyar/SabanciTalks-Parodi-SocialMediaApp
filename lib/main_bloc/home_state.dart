part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeLoad extends HomeState {
  final int counter;
  final bool isDarkMode;

  const HomeLoad({required this.counter, required this.isDarkMode});

  @override
  String toString() => 'HomeLoad with counter: $counter darkMode: $isDarkMode';

  @override
  List<Object?> get props => [
    counter,
    isDarkMode,
  ];
}