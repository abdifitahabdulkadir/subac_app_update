import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subac_app_update/config/state/firebase_constants.dart';

final appStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthInstanceProvider).authStateChanges();
});
