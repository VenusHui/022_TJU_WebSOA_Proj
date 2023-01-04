import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oneonly/utils/access.dart';

abstract class AssetsPickers {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<List<XFile>?> image({
    required BuildContext context,
    ImageSource source = ImageSource.gallery,
    double maxWidth = 512,
    double maxHeight = 512,
  }) async {
    if (!(await Access.photos())) {
      Access.setting();
      return null;
    }
    return _imagePicker.pickMultiImage(
        maxWidth: maxWidth, maxHeight: maxHeight, imageQuality: 50);
  }

  ///相机拍摄
  static Future<XFile?> cameraImage({
    required BuildContext context,
    ImageSource source = ImageSource.camera,
    double maxWidth = 512,
    double maxHeight = 512,
  }) async {
    if (!(await Access.photos())) {
      Access.setting();
      return null;
    }
    return _imagePicker.pickImage(
        maxWidth: maxWidth, maxHeight: maxHeight, source: source);
  }
}
