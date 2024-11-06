import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/features/files/domain/repository/file_repository.dart';
import '../../../core/styles/sizes.dart';

class ProfileAvatar extends StatefulWidget {
  final String? imageId;
  final String userInitials;
  final File? imageFile;
  final double? radius;

  const ProfileAvatar(
      {super.key,
      this.imageId,
      this.imageFile,
      required this.userInitials,
      this.radius});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  Future<Uint8List?>? _imageFuture;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(ProfileAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageId != oldWidget.imageId) {
      _loadImage();
    }
  }

  void _loadImage() {
    if (widget.imageId != null || widget.imageFile != null) {
      _imageFuture = context
          .read<FileRepository>()
          .getProfilePicById(profilePicId: widget.imageId!);
    } else {
      _imageFuture = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Try to load image
    return FutureBuilder<Uint8List?>(
      future: _imageFuture,
      builder: (context, snapshot) {
        // Show image if available
        final ImageProvider? foregroundImage = widget.imageFile != null
            ? FileImage(widget.imageFile!)
            : (snapshot.hasData && snapshot.data != null)
                ? MemoryImage(snapshot.data!)
                : null;
        return CircleAvatar(
          radius: widget.radius ?? KSizes.listItemCircleImageAvatarRadiusSize,
          backgroundColor:
              Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.9),
          foregroundColor:
              Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.9),
          foregroundImage: foregroundImage,
          child: foregroundImage != null
              ? null
              : Text(
                  widget.userInitials.toUpperCase(),
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: (widget.radius ??
                              KSizes.listItemCircleImageAvatarRadiusSize) *
                          0.8),
                ),
        );
      },
    );
  }
}
