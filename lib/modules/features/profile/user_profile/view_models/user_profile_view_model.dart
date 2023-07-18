import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moury/modules/data/user_config/models/user_config_response_models.dart';
import 'package:moury/modules/data/user_config/respository/user_config_repository.dart';
import '../../../../../core/services/network_services.dart';
import '../../../../../core/services/toast_services.dart';
import '../../../../data/base_model/base_model.dart';
import '../../../../data/user_profile/models/user_edit_reponse_model.dart';
import '../../../../data/user_profile/repository/user_repository.dart';

class UserProfileviewModel extends BaseModel {
  @override
  void onInit() {
    getUserConfig();
    super.onInit();
  }

  var image = XFile('').obs;
  final ImagePicker _picker = ImagePicker();
  var uploadedImageUrl = '';
  IUserRepository userRepository = UserRepository();
  IUserConfigRepository userConfigRepository = UserConfigRepository();
  UserConfigResponseModel? userConfigData;

  Future pickImage(ImageSource source, String name) async {
    final XFile? selectedImage =
        await _picker.pickImage(source: source, maxHeight: 500, maxWidth: 500);

    try {
      if (selectedImage != null) {
        final croppedFile = await cropImage(selectedImage);
        if (croppedFile != null) {
          // var result = await compressFile(File(croppedFile.path));
          image.value = XFile(croppedFile.path);
          if (image.value.path.isNotEmpty) {
            FirebaseStorage storage = FirebaseStorage.instance;
            Reference ref = storage.ref().child("upload${DateTime.now()}");
            File file = File(image.value.path);
            UploadTask uploadTask = ref.putFile(file);
            await uploadTask.then((res) async {
              uploadedImageUrl = await res.ref.getDownloadURL();
              await editUser(uploadedImageUrl, username: name);
              update();
            });
          } else {
            ToastService().e(
              'Please select an image first',
            );
          }
          await getUserConfig();

          update();
        }
      }
    } catch (error) {
      print("another:$error");
    }
  }

  Future<File?> cropImage(XFile? file) async {
    if (file == null) {
      return null;
    }
    try {
      var croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [CropAspectRatioPreset.square],
        uiSettings: [
          IOSUiSettings(
            title: 'Crop your image',
          ),
          AndroidUiSettings(
            toolbarTitle: 'Crop your image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
        ],
      );

      if (croppedFile != null) {
        image.value = XFile(
            croppedFile.path); // add this line to update image after cropping
      }
      return croppedFile != null ? File(croppedFile.path) : null;
    } catch (error) {
      print(error);
    }
    return null;
  }

  // Future<XFile> compressFile(File file) async {
  //   final dir = file.parent;
  //   final targetPath = "${dir.path}/temp_compressed.jpg";
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //     file.absolute.path,
  //     targetPath,
  //     quality: 100,
  //   );
  //   return result!;
  // }

  Future<void> editUser(String profilePicture, {String? username}) async {
    var result = await userRepository.editUserProfile(
        profilePicture: profilePicture, username: username);
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (UserEditResponseModel data) async {
        ToastService().s("User profile updated sucessfully!");
      },
    );
  }

  Future<void> getUserConfig() async {
    setLoading(true);

    var result = await userConfigRepository.getUserConfig();
    result.fold(
      (NetworkFailure error) {
        if (error.message?.isNotEmpty == true) {
          ToastService().e(error.message ?? '');
        } else {
          ToastService().e("An unknown error occurred");
        }
      },
      (UserConfigResponseModel data) async {
        userConfigData = data;
        // LocalStorageService()
        //     .write(LocalStorageKeys.accessToken, data.accessToken);
        update();
      },
    );
    setLoading(false);
  }
}
