import 'package:dartz/dartz.dart';
import 'package:subac_app_update/Features/Userprofile/Domain/entities/image_update_entity.dart';

import '../../../Authentication/core/Erros/auth_error_handling.dart';

abstract class UpdateUserImageRepository {
  Future<Either<AuthErrorHandling, bool>> updateUserImage(
      {required ImageUpdateEntity imageUpdateEntity});
}
