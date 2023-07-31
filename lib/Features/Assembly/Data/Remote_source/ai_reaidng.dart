import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// custom imports
import '/Features/Assembly/Data/Remote_source/read_ayah_provider.dart';
import 'read_error_text_provider.dart';
import '/Features/Assembly/Data/constants/constants_text.dart';
import '/Features/Assembly/Presentation/State/who_begins_provider.dart';
import '/Features/Assembly/Presentation/State/ayan_state_provider.dart';
import '/Features/Assembly/Presentation/State/dropdown_provider.dart';
import '/config/state/firebase_constants.dart';

aiReadingAyah(
    {required WidgetRef ref,
    required String reconizedWords,
    required BuildContext context,
    required int personTurn}) async {
  try {
    await ref
        .read(firebaseFirebaseInstanceProvider)
        .collection("islamic")
        .doc(ref.read(dropDownProvider))
        .get()
        .then((surahInformation) async {
      if (personTurn == 1) {
        if (ref.read(nextAyahIndexProvider) <
            (surahInformation.data()?["surah_data"] as List<dynamic>).length) {
          if (ref.read(nextAyahIndexProvider) == 0 &&
              ref.read(whoBeginsQuranReading) == 1) {
            await ref.read(readyCurrentAyahProvider.notifier).playAyah(
                ref: ref,
                ayahLength:
                    ((surahInformation.data()?["surah_data"] as List<dynamic>)
                        .length),
                ayahPath:
                    "${ref.read(dropDownProvider)}${ref.read(nextAyahIndexProvider)}");
            ref.read(nextAyahIndexProvider.notifier).incrementToNextAyah();
          } else {
            if (ref.read(nextAyahIndexProvider) == 0 ||
                reconizedWords.isNotEmpty) {
              final previousAyah = surahInformation.data()?["surah_data"]
                  [ref.read(nextAyahIndexProvider)]["simple"];

              if (previousAyah == reconizedWords) {
                if (ref.read(nextAyahIndexProvider) + 1 <
                    (surahInformation.data()?["surah_data"] as List<dynamic>)
                        .length) {
                  ref
                      .read(nextAyahIndexProvider.notifier)
                      .incrementToNextAyah();

                  await ref.read(readyCurrentAyahProvider.notifier).playAyah(
                      ref: ref,
                      ayahLength: ((surahInformation.data()?["surah_data"]
                              as List<dynamic>)
                          .length),
                      ayahPath:
                          "${ref.read(dropDownProvider)}${ref.read(nextAyahIndexProvider)}");
                  ref
                      .read(nextAyahIndexProvider.notifier)
                      .incrementToNextAyah();
                } else {
                  await ref
                      .read(playErrorTextProvider.notifier)
                      .readEndsWords(textToBeRead: textAfterSubacEnd);
                }
              } else {
                await ref
                    .read(playErrorTextProvider.notifier)
                    .palyErrorText(textToBeRead: textAfterUserRecitesWrongAyah);
              }
            } else {
              await ref.read(playErrorTextProvider.notifier).palyErrorText(
                  textToBeRead: textAfterUserSelectStartMeAndReadNothing);
            }
          }
        } else {
          await ref
              .read(playErrorTextProvider.notifier)
              .readEndsWords(textToBeRead: textAfterSubacEnd);
        }
      }
    }).onError((error, stackTrace) {
      print("error aya dhacay oo ah ${error.toString()}");
    });
  } catch (exception) {}
}
