import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subac_app_update/config/themes/switch_theme_state_provider.dart';

import '../../../../config/themes/theme_manager_provider.dart';

class Setting extends ConsumerWidget {
  static final String routeName = "/setting";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Setting", style: Theme.of(context).textTheme.displayLarge),
      ),
      body: SingleChildScrollView(
        child: SwitchListTile(
            title: Text("Theme"),
            value: ref.watch(switchThemeStateProvider),
            onChanged: (value) {
              ref
                  .watch(switchThemeStateProvider.notifier)
                  .update((state) => !ref.watch(switchThemeStateProvider));
              ref.watch(themeManagerProvider.notifier).state == ThemeMode.light
                  ? ref.watch(themeManagerProvider.notifier).state =
                      ThemeMode.dark
                  : ref.watch(themeManagerProvider.notifier).state =
                      ThemeMode.light;
              ref
                  .watch(switchThemeStateProvider.notifier)
                  .update((state) => !ref.watch(switchThemeStateProvider));
            }),
      ),
    );
  }
}
