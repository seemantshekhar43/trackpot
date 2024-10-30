import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageSelector{
  const ImageSelector._();
  static Future<File?>  pickImage(ImageSource source, BuildContext context) async {
    try {
      // Check permissions first
      final Permission permission = source == ImageSource.camera
          ? Permission.camera
          : Permission.photos;

      final status = await permission.request();

      if (!status.isGranted) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Permission denied. Please enable it in settings.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
        return null;
      }

      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 80, // Reduce image quality to save storage
        maxWidth: 1200,   // Limit max dimensions
        maxHeight: 1200,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: ${e.toString()}'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      return null;
    }
  }

}