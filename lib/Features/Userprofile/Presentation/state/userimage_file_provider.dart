import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/Features/Userprofile/Domain/entities/image_update_entity.dart';

import '../../Application/Usecases/update_userimage_usercase_implemented.dart';

class UserImageFileNotifier extends StateNotifier<File> {
  UserImageFileNotifier() : super(File(""));
  UpdateUserImageUsecaseImplemented _imageUsecaseImplemented =
      UpdateUserImageUsecaseImplemented();

  // set file to the state
  setFileToState({required File imageFile}) async {
    state = imageFile;
    await _imageUsecaseImplemented.updateUserImageUserCase(
        imageUpdateEntity: ImageUpdateEntity(imageFile: imageFile));
  }
}

final userImageFileProvider =
    StateNotifierProvider<UserImageFileNotifier, File>(
        (ref) => UserImageFileNotifier());
