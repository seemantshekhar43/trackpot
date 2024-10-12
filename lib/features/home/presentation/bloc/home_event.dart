part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class PageChangeEvent extends HomeEvent {
  final int index;

  PageChangeEvent(this.index);
}
