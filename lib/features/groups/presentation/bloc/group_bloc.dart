import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/exception/failure.dart';
import '../../domain/usecases/get_user_groups.dart';
import '../../domain/usecases/watch_user_groups.dart';

import '../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../domain/entities/group_summary.dart';
import '../../domain/repository/group_repository.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepository groupRepository;
  final AppUserCubit appUserCubit;
  StreamSubscription? _groupsSubscription;
  final WatchUserGroups watchUserGroup;
  final GetUserGroups getUserGroups;

  GroupBloc(this.groupRepository, this.appUserCubit, this.watchUserGroup,
      this.getUserGroups)
      : super(GroupInitial()) {
    on<LoadGroup>(_onLoadGroup);
    on<GroupUpdated>(_onGroupUpdated);
  }

  Future<void> _onLoadGroup(
    LoadGroup event,
    Emitter<GroupState> emit,
  ) async {
    emit(GroupLoading());

    final user = (appUserCubit.state as AppUserAuthenticated).user;

    //fetch user groups
    final Either<Failure, List<GroupSummary>> res =
        await getUserGroups.call(GetUserGroupsParams(id: user.id));

    res.fold(
      (failure) => emit(GroupError(failure.message)),
      (groups) => add(GroupUpdated(groups)),
    );

    // Subscribe to real-time updates
    _groupsSubscription?.cancel();
    final Either<Failure, Stream<List<GroupSummary>>> subs =
        await watchUserGroup.call(WatchUserGroupsParams(id: user.id));

    subs.fold(
        (failure) => emit(GroupError(failure.message)),
        (stream) => stream.listen(
              (groups) => add(GroupUpdated(groups)),
            ));
  }

  Future<void> _onGroupUpdated(
    GroupUpdated event,
    Emitter<GroupState> emit,
  ) async {
    try {
      double totalOwed = 0;
      double totalOwedTo = 0;

      // Calculate totals
      for (final group in event.groups) {
        if (group.userBalance < 0) {
          totalOwed += group.userBalance.abs();
        } else {
          totalOwedTo += group.userBalance;
        }
      }

      emit(GroupLoaded(
        groups: event.groups,
        totalOwed: totalOwed,
        totalOwedTo: totalOwedTo,
      ));
    } catch (e) {
      emit(GroupError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _groupsSubscription?.cancel();
    return super.close();
  }
}
