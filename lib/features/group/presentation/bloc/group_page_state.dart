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

  const GroupPageLoaded({
    required this.group,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [group, lastUpdated];
}

final class GroupPageError extends GroupPageState {
  final String message;

  const GroupPageError(this.message);

  @override
  List<Object?> get props => [message];
}
