import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../Features/Authentication/Domain/entities/login_user.dart';
import '../../../../Features/Authentication/Domain/usecases/login_user_usecase.dart';
import '../../Data/repositories/user_repository_implemented.dart';
import '../../core/Erros/auth_error_handling.dart';

class LoginUserUseCaseImplemented implements LoginUserUseCase {
  final UserRepositoryImplemented _userRepositoryImplemented =
      UserRepositoryImplemented();
  @override
  Future<Either<AuthErrorHandling, UserCredential>> loginUserUseCase(
      {required LoginUserEntity loginUserEntity}) async {
    return await _userRepositoryImplemented.loginUser(
        loginUserEntity: loginUserEntity);
  }
}
