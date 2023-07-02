import 'package:flutter/material.dart';

class TextFieldDesign extends StatelessWidget {
  final String hintText;
  final bool isTextHiddding;
  final TextInputType keyboardType;
  final IconData prefixIcon;
  final Function(String currentValue) saveValue;
  final String? Function(String? validateValue)? validator;

  TextFieldDesign({
    super.key,
    required this.saveValue,
    required this.validator,
    required this.prefixIcon,
    required this.hintText,
    required this.isTextHiddding,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: TextFormField(
        validator: validator,
        onChanged: saveValue,
        obscureText: isTextHiddding,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: Theme.of(context).primaryColor,
          ),
          labelText: hintText,
          hintStyle: Theme.of(context).textTheme.labelSmall,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 49, 202, 169))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 49, 202, 169))),
          fillColor: Colors.white,
          labelStyle: Theme.of(context).textTheme.labelSmall,
        ),
      ),
    );
  }
}
