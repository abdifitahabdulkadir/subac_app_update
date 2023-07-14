import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// custom imports
import '../state/updating_loading_state_provider.dart';
import '../Utitlities/send_updatingInformation.dart';
import '/Features/Userprofile/Presentation/widgets/user_photo.dart';
import '../widgets/text_field_design.dart';

class EditProfileInformation extends ConsumerStatefulWidget {
  static final String routeName = "/editProfileInformaiton";

  @override
  ConsumerState<EditProfileInformation> createState() =>
      _EditProfileInformationState();
}

class _EditProfileInformationState
    extends ConsumerState<EditProfileInformation> {
  // key for storing and validating the field validators
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _nameController = "";

  /*
  * this is the builder for button of save
  */
  Widget _buildSaveButton(
      {required BuildContext context, required WidgetRef ref}) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            sendingUpdatingInformationToUseCase(
                name: _nameController, ref: ref, context: context);
          }
        },
        child: Text(
          "Update",
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 20,
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 60,
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text("Edit Profile"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              UserPhoto(showCameraIcon: true),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Text(
                    "Personal information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      UserTextField(
                        saveValue: (enteredName) {
                          _nameController = enteredName;
                        },
                        validator: (currentName) {
                          if (currentName!.isEmpty) {
                            return "name can be empty";
                          } else if (currentName.length < 6) {
                            return "at least 5 characters";
                          }
                          return null;
                        },
                        prefixIcon: Icons.person,
                        hintText: "Name",
                        keyboardType: TextInputType.name,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              if (ref.watch(laodingStateUpdatingUserInformationProvider))
                Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                ),
              if (!ref.watch(laodingStateUpdatingUserInformationProvider))
                Center(child: _buildSaveButton(context: context, ref: ref))
            ],
          ),
        ));
  }
}
