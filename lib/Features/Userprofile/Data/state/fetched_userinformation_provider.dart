import 'package:flutter_riverpod/flutter_riverpod.dart';

class FetchedUserInformationProperties {
  String name;
  String email;

  FetchedUserInformationProperties({required this.email, required this.name});
}

class FetchedUserInformationPropertiesNotifier
    extends StateNotifier<FetchedUserInformationProperties> {
  FetchedUserInformationPropertiesNotifier()
      : super(FetchedUserInformationProperties(email: "", name: ""));

  // setting the names
  setFetchedUserName({required String email, required String name}) {
    state = FetchedUserInformationProperties(email: email, name: name);
  }
}

final FetchedUserInformationProvider = StateNotifierProvider<
        FetchedUserInformationPropertiesNotifier,
        FetchedUserInformationProperties>(
    (ref) => FetchedUserInformationPropertiesNotifier());
