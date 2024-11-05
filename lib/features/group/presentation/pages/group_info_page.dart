import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/group_member_role.dart';
import '../../../../core/constants/profile_constants.dart';
import '../../../../core/styles/sizes.dart';
import '../../../../core/widgets/list_divider.dart';
import '../../../../core/widgets/section_heading.dart';
import '../../../account/widgets/profile_avatar.dart';
import '../../../dashboard/domain/entities/group.dart';
import '../../../dashboard/presentation/widgets/group_avatar.dart';
import '../bloc/group_bloc.dart';
import '../widgets/members_list_item.dart';
import 'add_group.dart';

class GroupInfoPage extends StatelessWidget {
  final Group initialGroup;

  const GroupInfoPage({super.key, required this.initialGroup});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupBloc, GroupState>(listener: (context, state) {
      if (state case GroupError(:final message)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        body: switch (state) {
          GroupLoaded(:final group) => CustomScrollView(
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
                          Navigator.push(
                              context, AddGroupPage.route(groupToEdit: group));
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
                        imageId: group.groupPic,
                        category: group.category,
                        width: KSizes.containerSquareSMd,
                        height: KSizes.containerSquareSMd,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      horizontal: KSizes.md, vertical: KSizes.xs),
                  child: Text(group.name,
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
                          // Handle WhatsApp invite
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
                        label: '${group.members.length} members',
                      )),
                ),

                // Members List
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: group.members.length * 2,
                    (context, index) {
                      if (index.isEven) {
                        final memberIndex = index ~/ 2;
                        if (memberIndex >= group.members.length) return null;
                        final user = group.members[memberIndex].user;
                        return MembersListItem(
                            isDense: true,
                            title: ProfileConstants.displayName(
                                firstName: user.firstName,
                                lastName: user.lastName),
                            leadingWidget: ProfileAvatar(
                              radius:
                                  KSizes.listItemCircleImageAvatarRadiusSize,
                              userInitials: ProfileConstants.userInitials(
                                  firstName: user.firstName),
                              imageId: user.profilePicture,
                            ),
                            subtitle: group.members[memberIndex].role ==
                                    GroupMemberRole.admin
                                ? 'Admin'
                                : null,
                            onTap: () {});
                      } else {
                        return const ListDivider();
                      }
                    },
                  ),
                ),

                // Bottom padding to account for the Done button
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 80),
                  sliver: SliverToBoxAdapter(
                    child: SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          _ => const Center(child: CircularProgressIndicator()),
        },
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
              left: KSizes.md,
              right: KSizes.md,
              top: KSizes.smd,
              bottom: KSizes.lg),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              padding: const EdgeInsets.symmetric(vertical: KSizes.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(KSizes.sm),
              ),
            ),
            child: Text(
              'Done',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    });
  }
}
