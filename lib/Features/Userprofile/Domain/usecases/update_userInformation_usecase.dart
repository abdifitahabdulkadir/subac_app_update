import 'package:dartz/dartz.dart';

import '../../../Authentication/core/Erros/auth_error_handling.dart';
import '../entities/user_entity.dart';

abstract class UpdateUserInformationUsecase {
  Future<Either<AuthErrorHandling, void>> updateUserInformationUsecase(
      {required UserEntity userEntity});
}
