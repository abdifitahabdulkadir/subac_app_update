import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';

// my imports
import '/Features/Assembly/Presentation/State/ayan_state_provider.dart';
import '/Features/Assembly/Presentation/State/dropdown_provider.dart';
import '/Features/Assembly/Presentation/State/save_draft_state_provider.dart';
import '/Features/Assembly/Presentation/State/surah_ayan_length_provider.dart';

class SaveDraftSubac extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.watch(saveDraftSubacProvider.notifier).storeDraftData(
            surahName: ref.watch(dropDownProvider),
            ayahNumber: ref.watch(nextAyahIndexProvider) - 1,
            ref: ref,
            datetime: DateTime.now(),
            surahAyahLength: ref.read(surahAyahLengthProvider),
          ),
      child: Container(
        height: 50,
        width: 200,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ref.watch(saveDraftSubacProvider) == 1
            ? LoadingIndicator(indicatorType: Indicator.circleStrokeSpin)
            : Text(
                "Save as Draft",
                style: Theme.of(context).textTheme.bodySmall,
              ),
      ),
    );
  }
}
