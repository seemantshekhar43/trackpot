import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/group_member_role.dart';
import '../../../../core/constants/profile_constants.dart';
import '../../../../core/styles/sizes.dart';
import '../../../../core/widgets/list_divider.dart';
import '../../../../core/widgets/section_heading.dart';
import '../../../account/widgets/profile_avatar.dart';
import '../../../addMembers/presentation/pages/add_members_page.dart';
import '../../../dashboard/domain/entities/group.dart';
import '../../../dashboard/presentation/widgets/group_avatar.dart';
import '../bloc/group_info_bloc.dart';
import '../widgets/members_list_item.dart';
import 'add_group.dart';

class GroupInfoPage extends StatelessWidget {
  final Group initialGroup;

  const GroupInfoPage({super.key, required this.initialGroup});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupInfoBloc, GroupInfoState>(
        listener: (context, state) {
      if (state case GroupInfoError(:final message)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }

      if (state case GroupInfoNavigateBack(:final message)) {
        if (message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    }, builder: (context, state) {
      if (state is GroupInfoLoading) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      final group = state.group;

      return Scaffold(
        body: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              title: const Text('Group Info'),
              pinned: true,
              centerTitle: true,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: KSizes.md),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          AddGroupPage.route(groupToEdit: state.group));
                    },
                    child: Text('Edit',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                )
              ],
            ),

            // Padding for first section
            const SliverPadding(
              padding: EdgeInsets.only(bottom: KSizes.sm),
              sliver: SliverToBoxAdapter(
                child: SizedBox.shrink(),
              ),
            ),

            // Group Avatar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: KSizes.md, vertical: 0),
                child: Center(
                  child: GroupAvatar(
                    imageId: state.group.groupPic,
                    category: state.group.category,
                    width: KSizes.containerSquareSm,
                    height: KSizes.containerSquareSm,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                  horizontal: KSizes.md, vertical: KSizes.xs),
              child: Text(state.group.name,
                  style: Theme.of(context).textTheme.titleMedium),
            )),

            // Invite Members Section
            SliverToBoxAdapter(
              child: Container(
                  padding: const EdgeInsets.only(
                      left: KSizes.md,
                      right: KSizes.md,
                      top: KSizes.smd,
                      bottom: KSizes.xs),
                  child: const SectionHeading(
                    label: 'Invite members',
                  )),
            ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  // WhatsApp Invite
                  MembersListItem(
                    leadingWidget: const Icon(Icons.message_rounded),
                    title: 'Invite via WhatsApp',
                    onTap: () {
                      // Handle WhatsApp invite
                    },
                  ),
                  const ListDivider(),
                  MembersListItem(
                    leadingWidget: const Icon(Icons.share),
                    title: 'Share Invitation Link',
                    onTap: () {
                      // Handle WhatsApp invite
                    },
                  ),
                  const ListDivider(),
                  // Add Members
                  MembersListItem(
                    leadingWidget: const Icon(Icons.person_add),
                    title: 'Add Members',
                    onTap: () {
                      Navigator.push(
                          context, AddMembersPage.route(group: state.group));
                    },
                  ),
                  const ListDivider(),
                ],
              ),
            ),

            // Padding between sections
            const SliverPadding(
              padding: EdgeInsets.only(bottom: KSizes.sm),
              sliver: SliverToBoxAdapter(
                child: SizedBox.shrink(),
              ),
            ),

            // Members List Section Header
            SliverToBoxAdapter(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: KSizes.md, vertical: KSizes.md),
                  child: SectionHeading(
                    label: '${state.group.members.length} members',
                  )),
            ),

            // Members List
            SliverList.separated(
              itemCount: state.group.members.length,
              itemBuilder: (context, index) {
                final user = state.group.members[index].user;
                return MembersListItem(
                    title: ProfileConstants.displayName(
                        firstName: user.firstName, lastName: user.lastName),
                    leadingWidget: ProfileAvatar(
                      radius: KSizes.listItemCircleImageAvatarRadiusSize,
                      userInitials: ProfileConstants.userInitials(
                          firstName: user.firstName),
                      imageId: user.profilePicture,
                    ),
                    subtitle:
                        state.group.members[index].role == GroupMemberRole.admin
                            ? 'Admin'
                            : null,
                    onTap: () {});
              },
              separatorBuilder: (context, index) => const ListDivider(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 1, child: ListDivider()),
            ),
            SliverList.separated(
              itemCount: (context.read<GroupInfoBloc>().isUserAdmin()) ? 2 : 1,
              separatorBuilder: (context, index) => const ListDivider(),
              itemBuilder: (context, index) {
                return <Widget>[
                  MembersListItem(
                    title: 'Leave Group',
                    leadingWidget: const Icon(Icons.exit_to_app_outlined),
                    onTap: () async {
                      final shouldLeave = await _showConfirmationDialog(
                        context,
                        'Leave Group',
                        'Are you sure you want to leave this group? You will lose access to all expenses and settlements.',
                      );

                      if (shouldLeave && context.mounted) {
                        context
                            .read<GroupInfoBloc>()
                            .add(LeaveGroupInfo(group));
                      }
                    },
                  ),
                  MembersListItem(
                    title: 'Delete Group',
                    titleTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    leadingWidget: Icon(
                      Icons.delete_outline_outlined,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    onTap: () async {
                      final shouldDelete = await _showConfirmationDialog(
                        context,
                        'Delete Group',
                        'Are you sure you want to delete this group? All expenses and settlements will be permanently deleted.',
                      );

                      if (shouldDelete && context.mounted) {
                        context
                            .read<GroupInfoBloc>()
                            .add(DeleteGroupInfo(group));
                      }
                    },
                  ),
                ][index];
              },
            ),
            // Bottom padding to account for the Done button
            const SliverPadding(
              padding: EdgeInsets.only(bottom: KSizes.lg),
              sliver: SliverToBoxAdapter(
                child: SizedBox.shrink(),
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<bool> _showConfirmationDialog(
    BuildContext context,
    String title,
    String content,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
