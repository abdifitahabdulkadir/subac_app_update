import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/Features/Assembly/Data/Remote_source/read_error_text_provider.dart';
import '/Features/Assembly/Presentation/State/ayan_state_provider.dart';
import '/Features/Assembly/Presentation/State/who_begins_provider.dart';

class RestartQuran extends ConsumerWidget {
  const RestartQuran({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.watch(nextAyahIndexProvider.notifier).resetAyah();
        ref.watch(playErrorTextProvider.notifier).resetPlayErrorProvider();
        ref.watch(whoBeginsQuranReading.notifier).update((state) => 0);
      },
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.restart_alt,
          size: 50,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
