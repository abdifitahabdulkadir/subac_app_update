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
        height: 50,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 34),
        decoration: BoxDecoration(
          color: ref.watch(themeManagerProvider) == ThemeMode.light
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          onTap: () {},
          leading: isFacebook ? _facebookLocalImage : _googleLocalImage,
          title: Text(isFacebook ? "Sign with Facebook" : "Sign with Google",
              style: Theme.of(context).textTheme.bodySmall),
        ),
      ),
    );
  }
}
