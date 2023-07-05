import 'package:dartz/dartz.dart';

// custom imports
import '/Features/Authentication/core/Erros/auth_error_handling.dart';
import '../../Data/Repositories/user_profile_respository_implemented.dart';
import '../../Domain/usecases/fetching_userInformation_usecase.dart';

class FetchingUserInformationUseImpelmented
    implements FetchingUserInformationUseCase {
  UserProfileRepositoryImplemented _userProfileRepositoryImplemented =
      UserProfileRepositoryImplemented();
  @override
  Future<Either<AuthErrorHandling, Map<String, String>>>
      fetchUserCredialsUseCase() async {
    return await _userProfileRepositoryImplemented.fetchUserCredials();
  }
}
