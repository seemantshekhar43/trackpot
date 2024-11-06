import 'package:flutter/material.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/constants/profile_constants.dart';
import '../../../../core/styles/sizes.dart';
import '../../../account/widgets/profile_avatar.dart';

class SelectedUserChip extends StatelessWidget {
  final User user;
  final VoidCallback onDelete;
  const SelectedUserChip(
      {super.key, required this.user, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: KSizes.sm),
      child: Chip(
        avatar: ProfileAvatar(
          imageId: user.profilePicture,
          userInitials:
              ProfileConstants.userInitials(firstName: user.firstName),
        ),
        label: Text('${user.firstName} ${user.lastName}'),
        deleteIcon: const Icon(Icons.close, size: KSizes.iconSm),
        onDeleted: onDelete,
      ),
    );
  }
}
