import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// my imports
import '../../../../Features/Authentication/Presentation/widgets/button_design.dart';
import '../../../../Features/Authentication/Presentation/state/auth_state_provider.dart';
import '../../../../Features/Authentication/Presentation/widgets/text_field.dart';
import '../utitlities/send_user_to_provider.dart';
import '../utitlities/validate_email.dart';
import '/config/themes/theme_manager_provider.dart';

class RegisterLogin extends ConsumerWidget {
  RegisterLogin({super.key});

  String name = "";
  String email = "";
  String passowrd = "";
  final _formKey = GlobalKey<FormState>();

  /*
  * updating the isLoadingProvider to true if user clicks only 
  * either create and/or the login button depends on which screen he is.
  */
  void _updateTheLoadingState(
      {required WidgetRef ref,
      required BuildContext context,
      required bool islogin}) async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      _formKey.currentState!.save();
    }
    ref.read(isloadingProvider.notifier).update((state) => true);
    FocusScope.of(context).unfocus();
    await sendUserDataToProvider(
      ref: ref,
      islogin: islogin,
      email: email,
      password: passowrd,
      name: name,
    );
    ref.read(isloadingProvider.notifier).update((state) => false);
  }

  /*
  * this is the switching for login to register and register to login
  * it toggales the showLogin boolean variable to it's inverse of current value.
  * means true to false and false to true. 
  * then UI will reactive because it subscribes 
  * and watches the riverpod stateProvider in 
  * build method.
  */
  void _toggalingLoginShow({required WidgetRef ref}) => ref
      .read(showLoginProvider.notifier)
      .update((state) => !ref.read(showLoginProvider.notifier).state);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showLogin = ref.watch(showLoginProvider);
    final isloading = ref.watch(isloadingProvider);

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          toolbarHeight: 50,
          centerTitle: true,
          title: Text(
            showLogin ? "Login Your Account" : "Creating Account",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 49),
                if (!showLogin)
                  TextFieldDesign(
                    hintText: "Name",
                    isTextHiddding: false,
                    keyboardType: TextInputType.name,
                    prefixIcon: Icons.person,
                    saveValue: (currentValue) => name = currentValue,
                    validator: (currentName) {
                      if (currentName!.isEmpty) {
                        return "name can be empty";
                      } else if (currentName.length < 6) {
                        return "at least 5 characters";
                      }
                      return null;
                    },
                  ),
                TextFieldDesign(
                  hintText: "Email",
                  isTextHiddding: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  saveValue: (currentValue) => email = currentValue,
                  validator: (currentEmail) =>
                      validateEmail(email: currentEmail ?? ""),
                ),
                TextFieldDesign(
                    hintText: "Password",
                    isTextHiddding: true,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.lock,
                    saveValue: (currentValue) => passowrd = currentValue,
                    validator: (currentPassowrd) {
                      if (currentPassowrd!.isEmpty) {
                        return "Your password can not be empty";
                      } else if (currentPassowrd.length < 6) {
                        return "at least 6 characters ";
                      }
                      return null;
                    }),
                if (isloading)
                  CircularProgressIndicator(
                      color: ref.watch(themeManagerProvider) == ThemeMode.light
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onBackground),
                if (!isloading)
                  Container(
                    height: 60,
                    width: double.maxFinite,
                    margin: const EdgeInsets.symmetric(horizontal: 34),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () => _updateTheLoadingState(
                          ref: ref, context: context, islogin: showLogin),
                      child: Text(
                        showLogin ? "Login" : "Create Account",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                if (!isloading)
                  TextButton(
                    onPressed: () => _toggalingLoginShow(ref: ref),
                    child: Text(
                      showLogin
                          ? "Already have account ?login Here"
                          : "Dont have account?Create Now",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                if (!isloading)
                  Text("Or", style: Theme.of(context).textTheme.bodySmall),
                if (!isloading) ButtonDesign(isFacebook: true),
                if (!isloading) ButtonDesign(isFacebook: false)
              ],
            ),
          ),
        ));
  }
}
