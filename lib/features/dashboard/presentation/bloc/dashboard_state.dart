part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState extends Equatable {
  const DashboardState();
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<GroupSummary> groups;
  final double totalOwed; // Total amount user owes others
  final double totalOwedTo; // Total amount others owe to user

  const DashboardLoaded({
    required this.groups,
    required this.totalOwed,
    required this.totalOwedTo,
  });

  @override
  List<Object?> get props => [groups, totalOwed, totalOwedTo];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object> get props => [message];
}
