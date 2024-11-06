import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/constants/group_member_role.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../dashboard/domain/entities/group.dart';
import '../../../dashboard/domain/entities/group_member.dart';
import '../../domain/usecases/add_member.dart';
import '../../domain/usecases/get_all_users.dart';

part 'add_members_state.dart';

class AddMembersCubit extends Cubit<AddMembersState> {
  final GetAllUsers _getAllUsers;
  final AddMember _addMember;
  final Group group;

  AddMembersCubit({
    required GetAllUsers getAllUsers,
    required AddMember addMember,
    required this.group,
  })  : _getAllUsers = getAllUsers,
        _addMember = addMember,
        super(AddMembersInitial());

  Future<void> loadUsers() async {
    emit(AddMembersLoading());

    final result = await _getAllUsers(NoParams());

    result.fold(
      (failure) => emit(AddMembersError(message: failure.message)),
      (users) {
        emit(AddMembersSuccess(
          allUsers: users,
          filteredUsers: users,
          selectedUsers: const [],
        ));
      },
    );
  }

  void searchUsers(String query) {
    if (state is AddMembersSuccess) {
      final currentState = state as AddMembersSuccess;
      final lowercaseQuery = query.toLowerCase();
      final filtered = currentState.allUsers.where((user) {
        final fullName = '${user.firstName} ${user.lastName}'.toLowerCase();
        return fullName.contains(lowercaseQuery);
      }).toList();

      emit(currentState.copyWith(
        searchQuery: query,
        filteredUsers: filtered,
      ));
    }
  }

  void toggleUserSelection(User user) {
    if (state is AddMembersSuccess) {
      final currentState = state as AddMembersSuccess;
      final isSelected = currentState.selectedUsers.contains(user);
      final updatedSelection = isSelected
          ? currentState.selectedUsers.where((u) => u.id != user.id).toList()
          : [...currentState.selectedUsers, user];

      emit(currentState.copyWith(selectedUsers: updatedSelection));
    }
  }

  Future<void> addSelectedMembers() async {
    if (state is! AddMembersSuccess ||
        (state as AddMembersSuccess).selectedUsers.isEmpty) {
      return;
    }

    final currentState = state as AddMembersSuccess;
    emit(AddMembersLoading());

    final updatedGroup = await _addMember(
      AddMemberParams(
        group: group.copyWith(
          memberIds: [
            ...group.memberIds,
            ...currentState.selectedUsers.map((u) => u.id)
          ],
          members: [
            ...group.members,
            ...currentState.selectedUsers.map(
              (user) => GroupMember(
                id: '',
                groupId: group.id,
                user: user,
                role: GroupMemberRole.member,
                joinedAt: DateTime.now(),
              ),
            ),
          ],
        ),
      ),
    );

    updatedGroup.fold(
      (failure) => emit(AddMembersError(message: failure.message)),
      (group) =>
          emit(currentState), // Revert to success state after adding members
    );
  }
}
