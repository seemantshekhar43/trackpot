import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../styles/sizes.dart';
import '../utils/image_selector.dart';
import 'bottom_sheet_item.dart';

class PhotoSelectionBottomSheet extends StatelessWidget {
  const PhotoSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(KSizes.borderRadiusMd),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: KSizes.sm),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(KSizes.smd),
            child: Row(
              children: [
                BottomSheetItem(
                    label: 'Take Photo',
                    icon: Icons.camera_alt,
                    onTap: () async {
                      final file = await ImageSelector.pickImage(
                          ImageSource.camera, context);
                      if (context.mounted && file != null) {
                        Navigator.pop(context, file);
                      }
                    }),
                const SizedBox(width: KSizes.md),
                BottomSheetItem(
                    label: 'Pick from Gallery',
                    icon: Icons.photo_library,
                    onTap: () async {
                      final file = await ImageSelector.pickImage(
                          ImageSource.gallery, context);
                      if (context.mounted && file != null) {
                        Navigator.pop(context, file);
                      }
                    })
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + KSizes.md),
        ],
      ),
    );
  }
}

Future<File?> showPhotoSelectionBottomSheet(BuildContext context) async {
  return await showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return const PhotoSelectionBottomSheet();
    },
  );
}
