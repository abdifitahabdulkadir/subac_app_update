import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Features/Authentication/Domain/entities/login_user.dart';
import '../../Application/usecases/login_user_usecase_implemented.dart';
import '../../core/Erros/auth_error_handling.dart';

class LoginDataProperties {
  final String email;
  final String password;

  LoginDataProperties({required this.email, required this.password});
}

class LoginDataNotifier extends StateNotifier<LoginDataProperties> {
  final LoginUserUseCaseImplemented _loginUserUseCaseImplemented =
      LoginUserUseCaseImplemented();
  LoginDataNotifier() : super(LoginDataProperties(email: "", password: ""));

  // storing the data
  Future<Either<AuthErrorHandling, UserCredential>> collectLoginData(
      {required String email, required String password}) async {
    state = LoginDataProperties(email: email, password: password);
    return await _loginUserUseCaseImplemented.loginUserUseCase(
      loginUserEntity: LoginUserEntity(password: password, email: email),
    );
  }
}

final loginDataCollectingProvider =
    StateNotifierProvider<LoginDataNotifier, LoginDataProperties>(
        (ref) => LoginDataNotifier());
