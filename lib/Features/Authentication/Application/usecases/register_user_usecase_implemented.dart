import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:subac_app_update/Features/Authentication/Domain/entities/register_user.dart';
import 'package:subac_app_update/Features/Authentication/Domain/usecases/register_user_usecase.dart';

import '../../Data/repositories/user_repository_implemented.dart';
import '../../core/Erros/auth_error_handling.dart';

class RegisterUserCaseImplemented implements RegisterUseCase {
  final UserRepositoryImplemented _userRepositoryImplemented =
      UserRepositoryImplemented();
  @override
  Future<Either<AuthErrorHandling, UserCredential>> registerUserUseCase(
      {required RegisterUserEntity registerUserEntity}) async {
    return await _userRepositoryImplemented.registerUser(
        registerUserEntity: registerUserEntity);
  }
}
