import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../core/common/entities/user.dart';
import '../../../../core/constants/group_member_role.dart';
import '../../../dashboard/domain/entities/group.dart' as group_entity;
import '../../../group/presentation/bloc/group_page_bloc.dart';
import '../../domain/usecases/delete_group.dart';
import '../../domain/usecases/remove_member.dart';

part 'group_info_event.dart';
part 'group_info_state.dart';

class GroupInfoBloc extends Bloc<GroupInfoEvent, GroupInfoState> {
  final DeleteGroup deleteGroup;
  final RemoveMember removeMember;
  final AppUserCubit appUserCubit;
  final GroupPageBloc groupPageBloc;
  late final StreamSubscription<GroupPageState> _groupPageSubscription;

  GroupInfoBloc({
    required this.appUserCubit,
    required this.deleteGroup,
    required this.removeMember,
    required this.groupPageBloc,
    required group_entity.Group initialGroup,
  }) : super(GroupInfoLoaded(initialGroup)) {
    on<DeleteGroupInfo>(_onDeleteGroup);
    on<LeaveGroupInfo>(_onLeaveGroup);
    on<_UpdateGroup>(_onUpdateGroup);

    // Subscribe to GroupPageBloc state changes
    _groupPageSubscription = groupPageBloc.stream.listen((groupPageState) {
      if (groupPageState is GroupPageLoaded) {
        add(_UpdateGroup(groupPageState.group));
      }
    });
  }

  void _onUpdateGroup(
    _UpdateGroup event,
    Emitter<GroupInfoState> emit,
  ) {
    if (state is GroupInfoLoaded) {
      emit(GroupInfoLoaded(event.group));
    }
  }

  bool isUserAdmin({User? user}) {
    if (state is GroupInfoLoading) {
      return false;
    }
    user ??= (appUserCubit.state as AppUserAuthenticated).user;
    final group = state.group;
    return group.members
            .firstWhere((member) => member.user.id == user?.id)
            .role ==
        GroupMemberRole.admin;
  }

  Future<void> _onDeleteGroup(
    DeleteGroupInfo event,
    Emitter<GroupInfoState> emit,
  ) async {
    emit(GroupInfoLoading(state.group));

    final result = await deleteGroup(DeleteGroupParams(group: event.group));

    result.fold(
      (failure) => emit(GroupInfoError(failure.message, state.group)),
      (_) => emit(
          GroupInfoNavigateBack(state.group, 'Group successfully deleted')),
    );
  }

  Future<void> _onLeaveGroup(
    LeaveGroupInfo event,
    Emitter<GroupInfoState> emit,
  ) async {
    emit(GroupInfoLoading(state.group));

    final currentUser = (appUserCubit.state as AppUserAuthenticated).user;
    final currentMember = event.group.members
        .firstWhere((member) => member.user.id == currentUser.id);

    if (_isLastAdmin(event.group, currentUser)) {
      emit(GroupInfoError(
          "You are the only admin. Please make someone else admin before leaving.",
          state.group));
      return;
    }

    final updatedGroup = event.group.copyWith(
        memberIds: event.group.memberIds
            .where((memberId) => memberId != currentMember.user.id)
            .toList(),
        members: event.group.members
            .where((member) => member.id != currentMember.id)
            .toList());
    final result = await removeMember(
        RemoveMemberParams(currentMember, group: updatedGroup));

    result.fold(
      (failure) => emit(GroupInfoError(failure.message, state.group)),
      (_) =>
          emit(GroupInfoNavigateBack(state.group, 'You have left the group')),
    );
  }

  bool _isLastAdmin(group_entity.Group group, User currentUser) {
    final adminMembers = group.members
        .where((member) => member.role == GroupMemberRole.admin)
        .toList();
    return adminMembers.length == 1 &&
        adminMembers.first.user.id == currentUser.id;
  }

  @override
  Future<void> close() async {
    await _groupPageSubscription.cancel();
    return super.close();
  }
}
