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

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GroupRepository groupRepository;
  final AppUserCubit appUserCubit;
  StreamSubscription? _groupsSubscription;
  final WatchUserGroups watchUserGroup;
  final GetUserGroups getUserGroups;

  DashboardBloc(this.groupRepository, this.appUserCubit, this.watchUserGroup,
      this.getUserGroups)
      : super(DashboardInitial()) {
    on<LoadDashboard>(_onLoadGroups);
    on<DashboardUpdated>(_onGroupUpdated);
  }

  Future<void> _onLoadGroups(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      // Check if user is authenticated
      if (appUserCubit.state is! AppUserAuthenticated) {
        emit(const DashboardError('User not authenticated'));
        return;
      }

      // Show loading state
      emit(DashboardLoading());

      final user = (appUserCubit.state as AppUserAuthenticated).user;

      // Cancel any existing subscription
      await _groupsSubscription?.cancel();

      // Start listening to group updates using emit.forEach
      await emit.forEach<Either<Failure, List<GroupSummary>>>(
        watchUserGroup.call(WatchUserGroupsParams(id: user.id)).handleError(
          (error) {
            // Handle stream errors
            if (!emit.isDone) {
              emit(DashboardError(error.toString()));
            }
          },
        ),
        onData: (result) => result.fold(
          (failure) => DashboardError(failure.message),
          (groups) {
            double totalOwed = 0;
            double totalOwedTo = 0;

            // Calculate totals
            for (final group in groups) {
              if (group.userBalance < 0) {
                totalOwed += group.userBalance.abs();
              } else {
                totalOwedTo += group.userBalance;
              }
            }
            return DashboardLoaded(
              groups: groups,
              totalOwed: totalOwed,
              totalOwedTo: totalOwedTo,
            );
          },
        ),
      );
    } catch (e) {
      if (!emit.isDone) {
        emit(DashboardError(e.toString()));
      }
    }
  }

  Future<void> _onGroupUpdated(
    DashboardUpdated event,
    Emitter<DashboardState> emit,
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

      emit(DashboardLoaded(
        groups: event.groups,
        totalOwed: totalOwed,
        totalOwedTo: totalOwedTo,
      ));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _groupsSubscription?.cancel();
    return super.close();
  }
}
