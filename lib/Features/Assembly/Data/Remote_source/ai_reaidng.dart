import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

// custom imports
import '../DataState/read_ayah_provider.dart';
import '../DataState/read_error_text_provider.dart';
import '/Features/Assembly/Data/constants/constants_text.dart';
import '/Features/Assembly/Presentation/State/who_begins_provider.dart';
import '/Features/Assembly/Presentation/State/ayan_state_provider.dart';
import '/Features/Assembly/Presentation/State/dropdown_provider.dart';
import '/config/state/firebase_constants.dart';
import '/Features/Assembly/Presentation/State/surah_ayan_length_provider.dart';
import '/Features/Complete/Data/DataState/complete_state_provider.dart';

FlutterTts _flutterTts = FlutterTts();
Future<void> aiReadingAyah(
    {required WidgetRef ref,
    required String reconizedWords,
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
          ref
              .read(surahAyahLengthProvider.notifier)
              .registerCurrentAyahSurahLength(
                  ayahLength:
                      (surahInformation.data()?["surah_data"] as List<dynamic>)
                          .length);
          if (ref.read(nextAyahIndexProvider) == 0 &&
                  ref.read(whoBeginsQuranReading) == 1 ||
              ref.read(completeStateProvider) == 1) {
            await ref.read(readyCurrentAyahProvider.notifier).playAyah(
                ayahPath:
                    "${ref.read(dropDownProvider)}${ref.read(nextAyahIndexProvider)}");
            ref.read(nextAyahIndexProvider.notifier).incrementToNextAyah();
            ref
                .read(completeStateProvider.notifier)
                .makeStateTwoForFurtherReading();
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
                      ayahPath:
                          "${ref.read(dropDownProvider)}${ref.read(nextAyahIndexProvider)}");
                  ref
                      .read(nextAyahIndexProvider.notifier)
                      .incrementToNextAyah();
                } else {
                  ref.read(completeStateProvider.notifier).resetCompleteState();
                  ref.read(completeStateProvider.notifier).resetCompleteState();
                  ref.read(playErrorTextProvider.notifier).readEndsWords(
                        textToBeRead: textAfterSubacEnd,
                      );
                }
              } else {
                if (ref
                        .read(playErrorTextProvider.notifier)
                        .countNumberOfTimeUserRecitedWrongAyah ==
                    2) {
                  _flutterTts.setLanguage("en");
                  _flutterTts.setSpeechRate(0.4);
                  ref
                      .read(playErrorTextProvider.notifier)
                      .resetNumberOfTimesUserRecitedWrongAyah();
                  ref
                      .read(nextAyahIndexProvider.notifier)
                      .incrementToNextAyah();
                  _flutterTts.speak(textBeforeAiTakesUserTurn);
                  _flutterTts.setCompletionHandler(() {
                    ref
                        .read(readyCurrentAyahProvider.notifier)
                        .readAyahAfterUserRecitedWronglyThreeTimes(
                            ayahPath:
                                "${ref.read(dropDownProvider)}${ref.read(nextAyahIndexProvider) - 1}");
                  });
                } else {
                  ref
                      .read(playErrorTextProvider.notifier)
                      .palyErrorForWrongAyah(
                        ref: ref,
                        surahName: ref.read(dropDownProvider),
                        ayahNumber: ref.read(nextAyahIndexProvider),
                      );
                }
              }
            } else
              await ref
                  .read(playErrorTextProvider.notifier)
                  .palyErrorSoundAfterUserTurnReadsNothing(
                    textToBeRead: textAfterUserSelectStartMeAndReadNothing,
                  );
          }
        } else {
          ref.read(completeStateProvider.notifier).resetCompleteState();
          ref.read(playErrorTextProvider.notifier).readEndsWords(
                textToBeRead: textAfterSubacEnd,
              );
        }
      }
    }).onError((error, stackTrace) {
      print("error aya dhacay oo ah ${error.toString()}");
    });
  } catch (exception) {}
}
