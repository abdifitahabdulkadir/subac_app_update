import 'package:flutter_riverpod/flutter_riverpod.dart';

// custom imports
import '../DataState/read_ayah_provider.dart';
import '../DataState/read_error_text_provider.dart';
import '/Features/Assembly/Presentation/State/who_begins_provider.dart';
import '/Features/Assembly/Presentation/State/ayan_state_provider.dart';
import '/Features/Assembly/Presentation/State/dropdown_provider.dart';
import '/config/state/firebase_constants.dart';
import '/Features/Assembly/Presentation/State/surah_ayan_length_provider.dart';
import '/Features/Complete/Data/DataState/complete_state_provider.dart';

Future<void> aiReadingAyah(
    {required WidgetRef ref,
    required String reconizedWords,
  required int personTurn,
}) async {
  try {
    await ref
        .read(firebaseFirebaseInstanceProvider)
        .collection("islamic")
        .doc(ref.read(dropDownProvider))
        .get()
        .then((surahInformation) async {

      /*
      * this is the first time when ai is taking it's turn
      * it can also be when it is taking ayah at middle of subac .
      */
      // this if condition only is true when ai is should take ayah
      if (personTurn == 1) {
        // check if ayah remain like if some ayah are still remain
        if (ref.read(nextAyahIndexProvider) <
            (surahInformation.data()?["surah_data"] as List<dynamic>).length) {

          // registe current ayah
          ref
              .read(surahAyahLengthProvider.notifier)
              .registerCurrentAyahSurahLength(
                  ayahLength:
                      (surahInformation.data()?["surah_data"] as List<dynamic>)
                          .length);

          // check if it is first ayah to take in current surah
          // and ai is the one should take to
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
          }

          // otherwise , go inisde if previous if is false.
          //
          else {
            //check again we are current first ayah then if so
            // check if again we have any ayah recited by user
            // and if not empty -- means user recited something.
            // extract previous ayah-- ayah it is suppose user to read.

            if (ref.read(nextAyahIndexProvider) == 0 ||
                reconizedWords.isNotEmpty) {
              final previousAyah = surahInformation.data()?["surah_data"]
                  [ref.read(nextAyahIndexProvider)]["simple"];

              //compare prevous ayah and user's recited ayah.
              // if they are same, then check if ayah remain then if true
              // ai should take next ayah.
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
                }
                // they are same but no ayah remain
                // means user has recited last ayah then simply
                // play completion audio.
                else {
                  ref.read(completeStateProvider.notifier).resetCompleteState();
                  ref.read(playErrorTextProvider.notifier).readEndsWords();
                }
              }

              // if they are not same then play error audio
              // that tells user that he has recited wrong ayah.
              // and give back mic to him to again try.
              else {
                // somecases in user recite wrong ayah then simply
                // ai will take that turn and user then next turn
                // this if only executes that time.
                if (ref
                        .read(playErrorTextProvider.notifier)
                        .countNumberOfTimeUserRecitedWrongAyah ==
                    2) {
                  ref
                      .read(playErrorTextProvider.notifier)
                      .resetNumberOfTimesUserRecitedWrongAyah();
                  ref
                      .read(nextAyahIndexProvider.notifier)
                      .incrementToNextAyah();
                  await ref.read(readyCurrentAyahProvider.notifier).playAyah(
                      shouldItakeUserturn: true,
                      ayahPath:
                          "${ref.read(dropDownProvider)}${ref.read(nextAyahIndexProvider) - 1}");
                }

                // any other else then this else will handle
                // and it is when user ecited wrong ayah
                // it can be first time or second time.
                else {
                  ref
                      .read(playErrorTextProvider.notifier)
                      .palyErrorForWrongAyah(
                        ref: ref,
                        surahName: ref.read(dropDownProvider),
                        ayahNumber: ref.read(nextAyahIndexProvider),
                      );
                }
              }
            }
            // this only executes ai does not recognize any thing from usr side
            // but was the turn of usr to take ayah
            else
              await ref
                  .read(playErrorTextProvider.notifier)
                  .palyErrorSoundAfterUserTurnReadsNothing();
          }
        }

        //this only exectues when user takes last ayah or some good words
        // like saqalahul cadiim
        else {
          ref.read(completeStateProvider.notifier).resetCompleteState();
          ref.read(playErrorTextProvider.notifier).readEndsWords();
        }
      }
    }).onError((error, stackTrace) {
      print("error aya dhacay oo ah ${error.toString()}");
    });
  } catch (exception) {}
}
