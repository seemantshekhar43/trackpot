part of 'add_members_cubit.dart';

sealed class AddMembersState extends Equatable {
  const AddMembersState();

  @override
  List<Object?> get props => [];
}

class AddMembersInitial extends AddMembersState {}

class AddMembersLoading extends AddMembersState {}

class AddMembersError extends AddMembersState {
  final String message;

  const AddMembersError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AddMembersSuccess extends AddMembersState {
  final List<User> allUsers;
  final List<User> filteredUsers;
  final List<User> selectedUsers;
  final String searchQuery;

  const AddMembersSuccess({
    required this.allUsers,
    required this.filteredUsers,
    required this.selectedUsers,
    this.searchQuery = '',
  });

  AddMembersSuccess copyWith({
    List<User>? allUsers,
    List<User>? filteredUsers,
    List<User>? selectedUsers,
    String? searchQuery,
  }) {
    return AddMembersSuccess(
      allUsers: allUsers ?? this.allUsers,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      selectedUsers: selectedUsers ?? this.selectedUsers,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props =>
      [allUsers, filteredUsers, selectedUsers, searchQuery];
}
