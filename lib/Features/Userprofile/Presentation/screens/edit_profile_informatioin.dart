import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// custom imports
import '../state/updating_loading_state_provider.dart';
import '/Features/Authentication/Presentation/utitlities/validate_email.dart';
import '../Utitlities/send_updatingInformation.dart';
import '/Features/Userprofile/Presentation/widgets/user_photo.dart';
import '/Features/Userprofile/Presentation/Utitlities/fetch_first_userInformation.dart';
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

  TextEditingController _nameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  /*
  * this is the builder for button of save
  */
  Widget _buildSaveButton(
      {required BuildContext context, required WidgetRef ref}) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            sendingUpdatingInformationToUseCase(
                name: _nameController,
                email: _emailController,
                ref: ref,
                context: context);
          }
        },
        child: Text(
          "Update",
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    callFetchingFunction(
        nameController: _nameController,
        emailController: _emailController,
        context: context,
        ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 60,
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Edit Profile"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          _nameController.text = enteredName;
                        },
                        validator: (currentName) {
                          if (currentName!.isEmpty) {
                            return "name can be empty";
                          } else if (currentName.length < 6) {
                            return "at least 5 characters";
                          }
                          return null;
                        },
                        controller: _nameController,
                        prefixIcon: Icons.person,
                        hintText: "Name",
                        keyboardType: TextInputType.name,
                      ),
                      UserTextField(
                        saveValue: (enteredEmail) {
                          _emailController.text = enteredEmail;
                        },
                        validator: (value) =>
                            validateEmail(email: _emailController.text),
                        controller: _emailController,
                        prefixIcon: Icons.email,
                        hintText: "Email",
                        keyboardType: TextInputType.emailAddress,
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
