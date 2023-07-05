// calling update functin
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Application/Usecases/fetching_useruscae_implemented.dart';

// instance of fetching iformation implemented use case
FetchingUserInformationUseImpelmented _fetchInformationUseImple =
    FetchingUserInformationUseImpelmented();
void callFetchingFunction({
  required TextEditingController nameController,
  required TextEditingController emailController,
  required BuildContext context,
  required WidgetRef ref,
}) async {
  final result = await _fetchInformationUseImple.fetchUserCredialsUseCase();

  if (result.isRight()) {
    nameController.text = result.getOrElse(() => {})["name"] ?? "";
    emailController.text = result.getOrElse(() => {})["email"] ?? "";
  } else if (result.isLeft()) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.getOrElse(() => {}).toString())));
  }
}
