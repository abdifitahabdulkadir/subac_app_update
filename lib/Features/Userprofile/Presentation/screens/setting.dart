import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// my imports
import '../../../../config/themes/theme_manager_provider.dart';
import '../../../../config/utitlity/fetch_current_theme.dart';
import '/config/themes/switch_theme_state_provider.dart';

class Setting extends ConsumerWidget {
  static final String routeName = "/setting";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ref.watch(themeManagerProvider) == ThemeMode.light
          ? Colors.white
          : Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Setting", style: Theme.of(context).textTheme.displayLarge),
      ),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return SwitchListTile(
                title: Text(
                  ref.watch(switchThemeStateProvider)
                      ? "Light Mode"
                      : "Dark Mode",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                activeColor: ref.watch(themeManagerProvider.notifier).state ==
                        ThemeMode.light
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onBackground,
                value: ref.watch(switchThemeStateProvider),
                onChanged: (value) {
                  ref.read(themeManagerProvider.notifier).update(
                        (state) =>
                            ref.read(themeManagerProvider.notifier).state ==
                                    ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light,
                      );
                  fetchCurrentTheme(ref: ref);
                });
          },
        ),
      ),
    );
  }
}
