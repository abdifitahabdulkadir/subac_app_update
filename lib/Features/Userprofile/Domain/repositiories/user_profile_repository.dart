import 'package:dartz/dartz.dart';
import '/Features/Userprofile/Domain/entities/user_entity.dart';

import '../../../Authentication/core/Erros/auth_error_handling.dart';

abstract class UserProfileRepository {
 
  Future<Either<AuthErrorHandling, void>> updateUserInformation(
      {required UserEntity userEntity});
}
