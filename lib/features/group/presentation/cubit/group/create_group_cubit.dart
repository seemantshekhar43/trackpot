import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trackpot/features/dashboard/domain/entities/group_member.dart';

import '../../../../../core/common/cubits/app_user/app_user_cubit.dart';
import '../../../../../core/constants/group_member_role.dart';
import '../../../../dashboard/domain/entities/group.dart';
import '../../../../dashboard/domain/usecases/create_group.dart';
import '../../../domain/usecases/update_group.dart';

part 'create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  final CreateGroup _createGroup;
  final UpdateGroup _updateGroup;
  final AppUserCubit appUserCubit;

  CreateGroupCubit({
    required createGroup,
    required this.appUserCubit,
    required updateGroup,
  })  : _createGroup = createGroup,
        _updateGroup = updateGroup,
        super(const CreateGroupInitial());

  Future<void> createNewGroup({
    required String name,
    String? category,
    String? groupPic,
    required String defaultCurrency,
  }) async {
    emit(const CreateGroupLoading());

    final user = (appUserCubit.state as AppUserAuthenticated).user;
    final currentTime = DateTime.now();
    final group = Group(
      id: '', // Will be set by Appwrite
      name: name,
      category: category,
      groupPic: groupPic,
      currency: defaultCurrency,
      createdAt: currentTime,
      createdBy: user,
      members: [
        GroupMember(
            id: '',
            groupId: '',
            user: user,
            role: GroupMemberRole.admin,
            joinedAt: currentTime)
      ],
      memberIds: [user.id]
    );

    final createdGroup = await _createGroup(group);
    createdGroup.fold(
        (failure) => emit(CreateGroupError(message: failure.message)),
        (group) => emit(CreateGroupSuccess(group: group)));
  }

  Future<void> updateExistingGroup({
    required Group group,
    String? groupPic,
  }) async {
    emit(const CreateGroupLoading());

    final createdGroup =
        await _updateGroup(UpdateGroupParams(group: group, groupPic: groupPic));
    createdGroup.fold(
        (failure) => emit(CreateGroupError(message: failure.message)),
        (group) => emit(CreateGroupSuccess(group: group)));
  }
}
