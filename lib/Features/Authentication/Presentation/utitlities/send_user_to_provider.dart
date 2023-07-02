/*
  * this function is only to send data to the provider of regsiter user data
  * to store
  */
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/Erros/auth_error_handling.dart';
import '../state/login_user_provider.dart';
import '../state/register_user_provider.dart';

Future<Either<AuthErrorHandling, UserCredential>> sendUserDataToProvider({
  required WidgetRef ref,
  required bool islogin,
  required email,
  required String password,
  required String name,
}) async {
  if (islogin) {
    return await ref
        .read(loginDataCollectingProvider.notifier)
        .collectLoginData(email: email, password: password);
  } else {
    return await ref
        .read(registerDataCollectingProvider.notifier)
        .collectRegisterationData(
          name: name,
          email: email,
          password: password,
        );
  }
}
