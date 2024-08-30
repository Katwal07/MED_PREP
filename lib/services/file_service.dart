// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:image/image.dart' as Im;
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class FileService {
  var client = new Dio();

  // StorageService _storageService = locator<StorageService>();
  String userId = Uuid().v4();
  GetIt locator = GetIt.instance;
  ImagePicker picker = ImagePicker();

  Future<File?> pickImage(ImageSource imageSource, bool cropImage) async {
    try {
      XFile? pickedImage =
          await picker.pickImage(source: imageSource, imageQuality: 75);

      File image = File(pickedImage!.path);

      if (image == null) {
        return null;
      }

      if (cropImage) {
        if (image != null) {
          image = (await _cropImage(image))!;
        }

        if (image == null) {
          return null;
        }

        return await _compareImage(image);
      }

      return image;
    } catch (err) {
      print(err);

      throw err;
    }
  }

  Future<File> _compareImage(File file) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    Im.Image? imageFile = Im.decodeImage(file.readAsBytesSync());

    final compressedImageFile = File('$path/img_$userId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 70));

    return compressedImageFile;
  }


Future<File?> _cropImage(File imageFile) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    compressQuality: 50,
    compressFormat: ImageCompressFormat.png,
    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
      ),
      IOSUiSettings(
        title: 'Crop Image',
        aspectRatioLockEnabled: true,
        resetAspectRatioEnabled: false,
      ),
    ],
  );

  if (croppedFile != null) {
    return File(croppedFile.path);
  }
  return null;
}

  Future<File?> pickvideo(ImageSource imageSource, bool cropImage) async {
    try {
      XFile? pickedImage = await picker.pickVideo(
        source: imageSource,
      );

      File image = File(pickedImage!.path);

      if (image == null) {
        return null;
      }

      if (cropImage) {
        if (image != null) {
          image = (await _cropImage(image))!;
        }

        if (image == null) {
          return null;
        }

        return await _compareImage(image);
      }

      return image;
    } catch (err) {
      print(err);

      throw err;
    }
  }
}
