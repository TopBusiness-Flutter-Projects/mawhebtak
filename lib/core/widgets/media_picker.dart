import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaPickerHelper {
  static Future<void> pickImage({
    required Function(File image) onPicked,
  }) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      onPicked(File(picked.path));
    }
  }

  static Future<void> pickVideo({
    required Function(File video) onPicked,
  }) async {
    final picked = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (picked != null) {
      onPicked(File(picked.path));
    }
  }

  static Future<void> pickMedia({
    required BuildContext context,
    required Function(File image) onImagePicked,
    required Function(File video) onVideoPicked,
  }) async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: Text("pick_image".tr()),
                onTap: () {
                  Navigator.pop(context);
                  pickImage(onPicked: onImagePicked);
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam),
                title: Text("pick_video".tr()),
                onTap: () {
                  Navigator.pop(context);
                  pickVideo(onPicked: onVideoPicked);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
