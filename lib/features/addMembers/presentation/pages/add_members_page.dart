import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/profile_constants.dart';
import '../../../../core/styles/sizes.dart';
import '../../../../core/widgets/list_divider.dart';
import '../../../../init_dependencies.dart';
import '../../../account/widgets/profile_avatar.dart';
import '../../../dashboard/domain/entities/group.dart';
import '../../../groupInfo/presentation/widgets/members_list_item.dart';
import '../cubit/add_members_cubit.dart';
import '../widgets/selected_user_chip.dart';

class AddMembersPage extends StatelessWidget {
  final Group group;

  const AddMembersPage({
    super.key,
    required this.group,
  });

  static Route<void> route({required Group group}) {
    return MaterialPageRoute(
      builder: (_) => AddMembersPage(group: group),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<AddMembersCubit>(param1: group)..loadUsers(),
      child: const AddMembersView(),
    );
  }
}

class AddMembersView extends StatelessWidget {
  const AddMembersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddMembersCubit, AddMembersState>(
      listener: (context, state) {
        if (state is AddMembersError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add members'),
          ),
          body: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(KSizes.md),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search members...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(KSizes.borderRadiusLg),
                    ),
                  ),
                  onChanged: (value) {
                    context.read<AddMembersCubit>().searchUsers(value);
                  },
                ),
              ),

              // Selected Members Section
              if (state is AddMembersSuccess && state.selectedUsers.isNotEmpty)
                Container(
                  height: KSizes.containerSquareSm,
                  padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.selectedUsers.length,
                    itemBuilder: (context, index) {
                      final user = state.selectedUsers[index];
                      return SelectedUserChip(
                        user: user,
                        onDelete: () {
                          context
                              .read<AddMembersCubit>()
                              .toggleUserSelection(user);
                        },
                      );
                    },
                  ),
                ),

              const Divider(height: 1),

              if (state is AddMembersLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state is AddMembersSuccess &&
                  state.filteredUsers.isEmpty)
                const Expanded(
                  child: Center(child: Text('No users found')),
                )
              else if (state is AddMembersSuccess)
                Expanded(
                  child: ListView.separated(
                    itemCount: state.filteredUsers.length,
                    separatorBuilder: (_, __) => const ListDivider(),
                    itemBuilder: (context, index) {
                      final user = state.filteredUsers[index];
                      final isExistingMember = context
                          .read<AddMembersCubit>()
                          .group
                          .memberIds
                          .contains(user.id);
                      final isSelected = state.selectedUsers.contains(user);

                      return MembersListItem(
                        title: ProfileConstants.displayName(
                          firstName: user.firstName,
                          lastName: user.lastName,
                        ),
                        leadingWidget: ProfileAvatar(
                          userInitials: ProfileConstants.userInitials(
                            firstName: user.firstName,
                          ),
                          imageId: user.profilePicture,
                        ),
                        trailing: isExistingMember
                            ? Icon(
                                Icons.check_circle,
                                color: Theme.of(context).colorScheme.secondary,
                              )
                            : null,
                        tileColor: !isExistingMember && isSelected
                            ? Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withOpacity(0.1)
                            : null,
                        onTap: !isExistingMember
                            ? () {
                                context
                                    .read<AddMembersCubit>()
                                    .toggleUserSelection(user);
                              }
                            : () {},
                      );
                    },
                  ),
                ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: KSizes.md,
              vertical: KSizes.lg,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed:
                  state is! AddMembersSuccess || state.selectedUsers.isEmpty
                      ? null
                      : () async {
                          await context
                              .read<AddMembersCubit>()
                              .addSelectedMembers();
                          if (context.mounted &&
                              context.read<AddMembersCubit>().state
                                  is! AddMembersError) {
                            Navigator.of(context).pop();
                          }
                        },
              child: Text(
                state is AddMembersSuccess && state.selectedUsers.isNotEmpty
                    ? 'Add (${state.selectedUsers.length})'
                    : 'Add',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
