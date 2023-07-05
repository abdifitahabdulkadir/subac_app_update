import 'package:dartz/dartz.dart';
import '/Features/Authentication/core/Erros/auth_error_handling.dart';
import '/Features/Userprofile/Domain/entities/user_entity.dart';
import '../../Data/Repositories/user_profile_respository_implemented.dart';
import '../../Domain/usecases/update_userInformation_usecase.dart';

class UpdateUserInformationImplemented implements UpdateUserInformationUsecase {
  UserProfileRepositoryImplemented _userProfileRepositoryImplemented =
      UserProfileRepositoryImplemented();
  @override
  Future<Either<AuthErrorHandling, void>> updateUserInformationUsecase(
      {required UserEntity userEntity}) {
    return _userProfileRepositoryImplemented.updateUserInformation(
        userEntity: userEntity);
  }
}
