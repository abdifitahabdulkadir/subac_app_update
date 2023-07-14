import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/themes/theme_manager_provider.dart';

class OptionalPointingText extends ConsumerWidget {
  const OptionalPointingText({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 1,
            width: 80,
            decoration: BoxDecoration(
              color: ref.watch(themeManagerProvider) == ThemeMode.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
        Text("Or continue with ", style: Theme.of(context).textTheme.bodySmall),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 1,
            width: 80,
            decoration: BoxDecoration(
              color: ref.watch(themeManagerProvider) == ThemeMode.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
