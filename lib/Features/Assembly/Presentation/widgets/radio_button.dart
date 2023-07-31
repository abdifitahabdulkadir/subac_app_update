import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/Features/Assembly/Presentation/State/radio_button_provider.dart';
import 'package:subac_app_update/config/themes/theme_manager_provider.dart';

class RadioButtonDesign extends StatelessWidget {
  int radioButtonValue;
  String title;

  RadioButtonDesign({
    required this.radioButtonValue,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Flexible(
        child: Transform.scale(
          scale: 1,
          child: RadioListTile(
              activeColor: Color.fromARGB(255, 49, 202, 169),
              value: radioButtonValue,
              groupValue: ref.watch(radioButtonProvider),
              title: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ref.watch(themeManagerProvider) == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                    ),
              ),
              onChanged: (indexOfSelectedRadio) {
                ref
                    .read(radioButtonProvider.notifier)
                    .update((state) => indexOfSelectedRadio ?? 0);
              }),
        ),
      );
    });

    ;
  }
}
