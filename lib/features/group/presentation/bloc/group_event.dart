part of 'group_bloc.dart';


sealed class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object?> get props => [];
}

final class LoadGroup extends GroupEvent {
  final String groupId;

  const LoadGroup(this.groupId);

  @override
  List<Object?> get props => [groupId];
}

final class ClearGroup extends GroupEvent {
  const ClearGroup();
}
