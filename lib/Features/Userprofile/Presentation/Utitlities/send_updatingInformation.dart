import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// my custom imports
import '../../Application/Usecases/update_userinformation_implemented.dart';
import '../../Domain/entities/user_entity.dart';
import '../state/updating_loading_state_provider.dart';

// instance of update inofrmation implemented use case
UpdateUserInformationImplemented _updateUserInformationImplemented =
    UpdateUserInformationImplemented();
void sendingUpdatingInformationToUseCase(
    {required String name,
    required BuildContext context,
    required WidgetRef ref}) async {
  FocusScope.of(context).unfocus();
  ref
      .read(laodingStateUpdatingUserInformationProvider.notifier)
      .update((state) => true);
  final result = await _updateUserInformationImplemented
      .updateUserInformationUsecase(userEntity: UserEntity(name: name));
  ref
      .read(laodingStateUpdatingUserInformationProvider.notifier)
      .update((state) => false);
  if (result.isRight()) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Your name has been updated")));
   
  } else if (result.isLeft()) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("something Went wrong")));
  }
}
