import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// my imports
import '/config/themes/theme_manager_provider.dart';

class ButtonDesign extends ConsumerWidget {
  final Widget _facebookLocalImage = Image.asset(
      height: 30,
      "lib/Features/Authentication/Presentation/images/facebook.png");
  final Widget _googleLocalImage = Image.asset(
      height: 30, "lib/Features/Authentication/Presentation/images/google.png");

  bool isFacebook;
  ButtonDesign({super.key, required this.isFacebook});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 50,
        width: 50,
        margin: const EdgeInsets.symmetric(horizontal: 34),
        decoration: BoxDecoration(
          color: ref.watch(themeManagerProvider) == ThemeMode.light
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: isFacebook ? _facebookLocalImage : _googleLocalImage,
      ),
    );
  }
}
