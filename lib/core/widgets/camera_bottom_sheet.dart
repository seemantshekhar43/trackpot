import 'package:flutter/material.dart';

import '../styles/sizes.dart';
import 'bottom_sheet_item.dart';

void showPhotoSelectionBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
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
                      onTap: () {}),
                  const SizedBox(width: KSizes.md),
                  BottomSheetItem(
                      label: 'Pick from Gallery',
                      icon: Icons.photo_library,
                      onTap: () {})
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + KSizes.md),
          ],
        ),
      );
    },
  ).then((value) {
    if (value == 'camera') {
      // _takePhoto();
    } else if (value == 'gallery') {
      // _pickFromGallery();
    }
  });
}
