import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNameNotifer extends StateNotifier<String> {
  UserNameNotifer() : super("");

  // update the name
  updateUserName({required String newName}) {
    state = newName;
  }

  String get getUserName => state;
}

final fetchUsernameProvider =
    StateNotifierProvider<UserNameNotifer, String>((ref) => UserNameNotifer());
