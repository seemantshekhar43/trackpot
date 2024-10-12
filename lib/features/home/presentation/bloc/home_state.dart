part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final int index;
  const HomeState({required this.index});
}

final class HomeInitial extends HomeState {
  const HomeInitial({required super.index});
}
