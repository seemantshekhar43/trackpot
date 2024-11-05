part of 'group_bloc.dart';

sealed class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object?> get props => [];
}

final class GroupInitial extends GroupState {
  const GroupInitial();
}

final class GroupLoading extends GroupState {
  const GroupLoading();
}

final class GroupLoaded extends GroupState {
  final group_entity.Group group;
  final DateTime lastUpdated;

  const GroupLoaded({
    required this.group,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [group, lastUpdated];
}

final class GroupError extends GroupState {
  final String message;

  const GroupError(this.message);

  @override
  List<Object?> get props => [message];
}
