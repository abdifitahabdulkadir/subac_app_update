import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:subac_app_update/Features/Authentication/Domain/entities/login_user.dart';

import '../../core/Erros/auth_error_handling.dart';

abstract class LoginUserUseCase {
  Future<Either<AuthErrorHandling, UserCredential>> loginUserUseCase(
      {required LoginUserEntity loginUserEntity});
}
