import 'package:dartz/dartz.dart';
import '/Features/Userprofile/Domain/entities/image_update_entity.dart';

import '../../../Authentication/core/Erros/auth_error_handling.dart';

abstract class UpdateUserImageUsecase {
  Future<Either<AuthErrorHandling, bool>> updateUserImageUserCase(
      {required ImageUpdateEntity imageUpdateEntity});
}
