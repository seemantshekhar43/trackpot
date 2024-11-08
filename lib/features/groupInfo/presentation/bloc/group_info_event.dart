part of 'group_info_bloc.dart';

sealed class GroupInfoEvent extends Equatable {
  const GroupInfoEvent();

  @override
  List<Object?> get props => [];
}

final class DeleteGroupInfo extends GroupInfoEvent {
  final group_entity.Group group;
  const DeleteGroupInfo(this.group);

  @override
  List<Object?> get props => [group];
}

final class LeaveGroupInfo extends GroupInfoEvent {
  final group_entity.Group group;
  const LeaveGroupInfo(this.group);

  @override
  List<Object?> get props => [group];
}

final class _UpdateGroup extends GroupInfoEvent {
  final group_entity.Group group;
  const _UpdateGroup(this.group);

  @override
  List<Object?> get props => [group];
}
