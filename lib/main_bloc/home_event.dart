part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeStarting extends HomeEvent {
  const HomeStarting();

  @override
  String toString() => 'HomePage loading';
}

class HomeIncrementButtonTapEvent extends HomeEvent {
  const HomeIncrementButtonTapEvent();

  @override
  String toString() => 'Increment button tapped in homepage';
}

class HomeDecrementButtonTapEvent extends HomeEvent {
  const HomeDecrementButtonTapEvent();

  @override
  String toString() => 'Decrement button tapped in homepage';
}

class HomeToggleButtonTapEvent extends HomeEvent {
  const HomeToggleButtonTapEvent();

  @override
  String toString() => 'Toggle button tapped in homepage';
}

