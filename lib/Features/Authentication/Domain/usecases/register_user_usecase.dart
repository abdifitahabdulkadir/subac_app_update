import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../Features/Authentication/Domain/entities/register_user.dart';
import '../../core/Erros/auth_error_handling.dart';

abstract class RegisterUseCase {
  Future<Either<AuthErrorHandling, UserCredential>> registerUserUseCase(
      {required RegisterUserEntity registerUserEntity});
}
