import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../../../dashboard/domain/entities/group.dart' as group_entity;
import '../../domain/usecases/watch_group_by_id.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final WatchGroupById watchGroupById;
  StreamSubscription<Either<Failure, group_entity.Group>>? _groupSubscription;

  GroupBloc({
    required this.watchGroupById,
  }) : super(const GroupInitial()) {
    on<LoadGroup>(_onLoadGroup);
    on<ClearGroup>(_onClearGroup);
  }

  Future<void> _onLoadGroup(
    LoadGroup event,
    Emitter<GroupState> emit,
  ) async {
    try {
      emit(const GroupLoading());

      await _groupSubscription?.cancel();

      await emit.forEach<Either<Failure, group_entity.Group>>(
        watchGroupById
            .call(WatchGroupByIdParams(groupId: event.groupId))
            .handleError(
          (error) {
            if (!emit.isDone) {
              emit(GroupError(error.toString()));
            }
          },
        ),
        onData: (result) => result.fold(
          (failure) => GroupError(failure.message),
          (group) => GroupLoaded(
            group: group,
            lastUpdated: DateTime.now(),
          ),
        ),
      );
    } catch (e) {
      if (!emit.isDone) {
        emit(GroupError(e.toString()));
      }
    }
  }

  void _onClearGroup(
    ClearGroup event,
    Emitter<GroupState> emit,
  ) async {
    await _groupSubscription?.cancel();
    emit(const GroupInitial());
  }

  @override
  Future<void> close() async {
    await _groupSubscription?.cancel();
    return super.close();
  }
}
