part of 'group_bloc.dart';

@immutable
sealed class GroupState extends Equatable {
  const GroupState();
  @override
  List<Object?> get props => [];
}

class GroupInitial extends GroupState {}

class GroupLoading extends GroupState {}

class GroupLoaded extends GroupState {
  final List<GroupSummary> groups;
  final double totalOwed; // Total amount user owes others
  final double totalOwedTo; // Total amount others owe to user

  const GroupLoaded({
    required this.groups,
    required this.totalOwed,
    required this.totalOwedTo,
  });

  @override
  List<Object?> get props => [groups, totalOwed, totalOwedTo];
}

class GroupError extends GroupState {
  final String message;

  const GroupError(this.message);

  @override
  List<Object> get props => [message];
}
