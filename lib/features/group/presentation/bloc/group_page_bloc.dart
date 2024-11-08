import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/exception/failure.dart';
import '../../../dashboard/domain/entities/group.dart' as group_entity;
import '../../domain/usecases/watch_group_by_id.dart';

part 'group_page_event.dart';
part 'group_page_state.dart';

class GroupPageBloc extends Bloc<GroupPageEvent, GroupPageState> {
  final WatchGroupById watchGroupById;
  StreamSubscription<Either<Failure, group_entity.Group>>? _groupSubscription;

  GroupPageBloc({
    required this.watchGroupById,
  }) : super(const GroupPageInitial()) {
    on<LoadGroupPage>(_onLoadGroup);
    on<ClearGroupPage>(_onClearGroup);
  }

  Future<void> _onLoadGroup(
    LoadGroupPage event,
    Emitter<GroupPageState> emit,
  ) async {
    try {
      emit(const GroupPageLoading());

      await _groupSubscription?.cancel();

      await emit.forEach<Either<Failure, group_entity.Group>>(
        watchGroupById
            .call(WatchGroupByIdParams(groupId: event.groupId))
            .handleError(
          (error) {
            if (!emit.isDone) {
              emit(GroupPageError(error.toString()));
            }
          },
        ),
        onData: (result) => result.fold(
          (failure) => GroupPageError(failure.message),
          (group) => GroupPageLoaded(
            group: group,
            lastUpdated: DateTime.now(),
          ),
        ),
      );
    } catch (e) {
      if (!emit.isDone) {
        emit(GroupPageError(e.toString()));
      }
    }
  }

  void _onClearGroup(
    ClearGroupPage event,
    Emitter<GroupPageState> emit,
  ) async {
    await _groupSubscription?.cancel();
    emit(const GroupPageInitial());
  }

  @override
  Future<void> close() async {
    await _groupSubscription?.cancel();
    return super.close();
  }
}
