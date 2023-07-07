import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// my imports
import '/config/themes/theme_manager_provider.dart';
import '../../Features/Authentication/core/Erros/auth_error_handling.dart';

class ThemeManagementRepository {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<Either<AuthErrorHandling, bool>> storeAppTheme(
      {required WidgetRef ref}) async {
    bool isErrorHappened = false;

    String errorMessage = "";
    print("wala yimid");
    try {
      await _firebaseFirestore
          .collection("appTheme")
          .doc(_firebaseAuth.currentUser!.uid)
          .set({
        "themeType": ref.read(themeManagerProvider) == ThemeMode.light
            ? "light"
            : "dark",
      });
      isErrorHappened = false;
    } catch (exception) {
      isErrorHappened = true;
      print("error aya dhacay");
      print(exception);
      errorMessage = exception.toString();
    }

    return isErrorHappened
        ? left(AuthErrorHandling(errorMessage: errorMessage))
        : Right(isErrorHappened);
  }
}
