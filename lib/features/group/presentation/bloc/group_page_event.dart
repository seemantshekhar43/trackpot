part of 'group_page_bloc.dart';

sealed class GroupPageEvent extends Equatable {
  const GroupPageEvent();

  @override
  List<Object?> get props => [];
}

final class LoadGroupPage extends GroupPageEvent {
  final String groupId;

  const LoadGroupPage(this.groupId);

  @override
  List<Object?> get props => [groupId];
}

final class ChangeGroupTab extends GroupPageEvent {
  final int tabIndex;

  const ChangeGroupTab(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

final class ClearGroupPage extends GroupPageEvent {
  const ClearGroupPage();
}