part of 'group_page_bloc.dart';

sealed class GroupPageState extends Equatable {
  const GroupPageState();

  @override
  List<Object?> get props => [];
}

final class GroupPageInitial extends GroupPageState {
  const GroupPageInitial();
}

final class GroupPageLoading extends GroupPageState {
  const GroupPageLoading();
}

final class GroupPageLoaded extends GroupPageState {
  final group_entity.Group group;
  final DateTime lastUpdated;
  final int activeTab; // 0: Expenses, 1: Balances, 2: Totals

  const GroupPageLoaded({
    required this.group,
    required this.lastUpdated,
    required this.activeTab,
  });

  GroupPageLoaded copyWith({
    group_entity.Group? group,
    DateTime? lastUpdated,
    int? activeTab,
  }) {
    return GroupPageLoaded(
      group: group ?? this.group,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      activeTab: activeTab ?? this.activeTab,
    );
  }

  @override
  List<Object?> get props => [group, lastUpdated, activeTab];
}

final class GroupPageError extends GroupPageState {
  final String message;

  const GroupPageError(this.message);

  @override
  List<Object?> get props => [message];
}