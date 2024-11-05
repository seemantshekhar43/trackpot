part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboard extends DashboardEvent {}

class DashboardUpdated extends DashboardEvent {
  final List<GroupSummary> groups;

  const DashboardUpdated(this.groups);

  @override
  List<Object> get props => [groups];
}
