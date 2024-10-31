part of 'group_bloc.dart';

@immutable
sealed class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object?> get props => [];
}

class LoadGroup extends GroupEvent {}

class GroupUpdated extends GroupEvent {
  final List<GroupSummary> groups;

  const GroupUpdated(this.groups);

  @override
  List<Object> get props => [groups];
}
