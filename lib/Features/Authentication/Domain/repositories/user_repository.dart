import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

// custom imports
import '../.../../../../../Features/Authentication/core/Erros/auth_error_handling.dart';
import '../.../../../../../Features/Authentication/Domain/entities/login_user.dart';
import '../.../../../../../Features/Authentication/Domain/entities/register_user.dart';

abstract class UserRepository {
  Future<Either<AuthErrorHandling, UserCredential>> registerUser(
      {required RegisterUserEntity registerUserEntity});
  Future<Either<AuthErrorHandling, UserCredential>> loginUser(
      {required LoginUserEntity loginUserEntity});
}
