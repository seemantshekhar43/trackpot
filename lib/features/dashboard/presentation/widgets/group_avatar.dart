import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/features/files/domain/repository/file_repository.dart';
import '../../../../core/constants/group_constants.dart';
import '../../../../core/styles/sizes.dart';

class GroupAvatar extends StatefulWidget {
  final String? imageId;
  final String? category;
  final double width;
  final double height;

  const GroupAvatar({
    super.key,
    this.imageId,
    this.category,
    this.height = KSizes.imageThumbSize,
    this.width = KSizes.imageThumbSize,

  });

  @override
  State<GroupAvatar> createState() => _GroupAvatarState();
}

class _GroupAvatarState extends State<GroupAvatar> {
  Future<Uint8List?>? _imageFuture;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(GroupAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageId != oldWidget.imageId) {
      _loadImage();
    }
  }

  void _loadImage() {
    if (widget.imageId != null) {
      _imageFuture = context
          .read<FileRepository>()
          .getGroupPicById(groupPicId: widget.imageId!);
    } else {
      _imageFuture = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // If no imageId, show fallback immediately
    if (widget.imageId == null) {
      return _buildFallbackAvatar(context);
    }

    // Try to load image
    return FutureBuilder<Uint8List?>(
      future: _imageFuture,
      builder: (context, snapshot) {
        // Show image if available
        if (snapshot.hasData && snapshot.data != null) {
          return Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Theme.of(context)
                      .colorScheme
                      .onInverseSurface
                      .withOpacity(0.9),
                  borderRadius: BorderRadius.circular(KSizes.smd)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(KSizes.smd),
                  child: Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  )));
        }

        // Show fallback for any other case (error, null, loading)
        return _buildFallbackAvatar(context);
      },
    );
  }

  Widget _buildFallbackAvatar(BuildContext context) {
    return Container(
      width: KSizes.imageThumbSize,
      height: KSizes.imageThumbSize,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color:
              Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.9),
          borderRadius: BorderRadius.circular(KSizes.smd)),
      child: Icon(
        _getIconForCategory(widget.category),
        size: KSizes.iconLg,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  IconData _getIconForCategory(String? category) {
    if (category == null) return Icons.group_rounded;
    return GroupConstants.categories.firstWhere(
      (categoryItem) =>
          categoryItem['name'].toLowerCase() == category.toLowerCase(),
      orElse: () => {'icon': Icons.group_rounded},
    )['icon'];
  }
}
