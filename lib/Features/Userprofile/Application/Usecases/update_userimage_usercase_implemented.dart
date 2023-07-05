import 'package:dartz/dartz.dart';
import 'package:subac_app_update/Features/Authentication/core/Erros/auth_error_handling.dart';
import 'package:subac_app_update/Features/Userprofile/Domain/entities/image_update_entity.dart';
import 'package:subac_app_update/Features/Userprofile/Domain/usecases/update-userImage_usecase.dart';

import '../../Data/Repositories/update_userprofile_repository_implemented.dart';

class UpdateUserImageUsecaseImplemented implements UpdateUserImageUsecase {
  UpdateUserImageRepositoryImplemented _imageRepositoryImplemented =
      UpdateUserImageRepositoryImplemented();
  @override
  Future<Either<AuthErrorHandling, bool>> updateUserImageUserCase(
      {required ImageUpdateEntity imageUpdateEntity}) async {
    return await _imageRepositoryImplemented.updateUserImage(
        imageUpdateEntity: imageUpdateEntity);
  }
}
