import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subac_app_update/config/themes/theme_manager_provider.dart';

class UserTextField extends ConsumerWidget {
  final String hintText;
  final TextInputType keyboardType;
  final IconData prefixIcon;

  final Function(String currentValue) saveValue;
  final String? Function(String? validateValue)? validator;

  UserTextField({
    super.key,
    required this.saveValue,
    required this.validator,
    required this.prefixIcon,
    required this.hintText,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: TextFormField(
        validator: validator,
        onChanged: saveValue,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: Theme.of(context).iconTheme.color,
          ),
          labelText: hintText,
          hintStyle: Theme.of(context).textTheme.labelSmall,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: ref.watch(themeManagerProvider) == ThemeMode.light
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.background,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: ref.watch(themeManagerProvider) == ThemeMode.light
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.background,
          )),
          fillColor: Colors.red,
          labelStyle: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}
