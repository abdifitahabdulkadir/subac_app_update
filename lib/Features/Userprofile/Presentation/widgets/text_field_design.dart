import 'package:flutter/material.dart';

class UserTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final IconData prefixIcon;
  TextEditingController controller;
  final Function(String currentValue) saveValue;
  final String? Function(String? validateValue)? validator;

  UserTextField({
    super.key,
    required this.controller,
    required this.saveValue,
    required this.validator,
    required this.prefixIcon,
    required this.hintText,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: TextFormField(
        validator: validator,
        onChanged: saveValue,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: Theme.of(context).primaryColor),
          labelText: hintText,
          hintStyle: Theme.of(context).textTheme.labelSmall,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          fillColor: Colors.white,
          labelStyle: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}
