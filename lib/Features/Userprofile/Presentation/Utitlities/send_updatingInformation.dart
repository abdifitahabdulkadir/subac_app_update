import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// my custom imports
import '../../Application/Usecases/update_userinformation_implemented.dart';
import '../../Domain/entities/user_entity.dart';
import '../state/updating_loading_state_provider.dart';
import 'fetch_first_userInformation.dart';

// instance of update inofrmation implemented use case
UpdateUserInformationImplemented _updateUserInformationImplemented =
    UpdateUserInformationImplemented();
void sendingUpdatingInformationToUseCase(
    {required TextEditingController name,
    required TextEditingController email,
    required BuildContext context,
    required WidgetRef ref}) async {
  FocusScope.of(context).unfocus();
  ref
      .read(laodingStateUpdatingUserInformationProvider.notifier)
      .update((state) => true);
  final result =
      await _updateUserInformationImplemented.updateUserInformationUsecase(
          userEntity: UserEntity(email: email.text, name: name.text));
  ref
      .read(laodingStateUpdatingUserInformationProvider.notifier)
      .update((state) => false);
  if (result.isRight()) {
    callFetchingFunction(
      nameController: name,
      emailController: email,
      context: context,
      ref: ref,
    );
  } else if (result.isLeft()) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("something Went wrong")));
  }
}
