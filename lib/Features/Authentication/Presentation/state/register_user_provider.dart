import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Application/usecases/register_user_usecase_implemented.dart';
import '../../core/Erros/auth_error_handling.dart';
import '../../../../Features/Authentication/Domain/entities/register_user.dart';

class RegisterDataProperties {
  final String name;
  final String email;
  final String password;

  RegisterDataProperties(
      {required this.email, required this.password, required this.name});
}

class RegisterDataNotifier extends StateNotifier<RegisterDataProperties> {
  final RegisterUserCaseImplemented _registerUserCaseImplemented =
      RegisterUserCaseImplemented();
  RegisterDataNotifier()
      : super(RegisterDataProperties(email: "", password: "", name: ""));

  // storing the data
  Future<Either<AuthErrorHandling, UserCredential>> collectRegisterationData(
      {required String name,
      required String email,
      required String password}) async {
    state =
        RegisterDataProperties(email: email, password: password, name: name);
    return await _registerUserCaseImplemented.registerUserUseCase(
      registerUserEntity: RegisterUserEntity(
          password: password, userEmail: email, username: name),
    );
  }
}

final registerDataCollectingProvider =
    StateNotifierProvider<RegisterDataNotifier, RegisterDataProperties>(
        (ref) => RegisterDataNotifier());
