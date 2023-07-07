import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/config/themes/theme_manager_provider.dart';

// my imports
import '/Features/Assembly/Presentation/State/assembly_provider.dart';
import '/Features/Complete/Presentation/State/complete_assembly_provider.dart';
import '/Features/SfRadialGauge/Presentation/state/radial_provider.dart';

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0,
      color: ref.watch(themeManagerProvider) == ThemeMode.light
          ? Theme.of(context).colorScheme.onPrimary
          : Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref.watch(assemblyProvider);
          }),
          const SizedBox(height: 35),
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ref.watch(completeAssemblyProvider);
          }),
          SizedBox(height: 20),
          ref.watch(radialProvider),
        ],
      ),
    );
  }
}
