part of 'group_info_bloc.dart';

sealed class GroupInfoState extends Equatable {
  final group_entity.Group group;
  const GroupInfoState(this.group);

  @override
  List<Object?> get props => [];
}

final class GroupInfoInitial extends GroupInfoState {
  const GroupInfoInitial(super.group);
}

final class GroupInfoLoading extends GroupInfoState {
  const GroupInfoLoading(super.group);
}

final class GroupInfoError extends GroupInfoState {
  final String message;

  const GroupInfoError(this.message, super.group);

  @override
  List<Object?> get props => [message];
}

final class GroupInfoNavigateBack extends GroupInfoState {
  final String? message;
  const GroupInfoNavigateBack(super.group, [this.message]);

  @override
  List<Object?> get props => [message];
}

final class GroupInfoLoaded extends GroupInfoState {
  const GroupInfoLoaded(super.group);

  @override
  List<Object?> get props => [group];
}
