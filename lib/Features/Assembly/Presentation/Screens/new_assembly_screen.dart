import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';

// my custom imports
import '/Features/Assembly/Presentation/State/mic_listening_provider.dart';
import '/Features/Complete/Data/DataState/complete_state_provider.dart';
import '../../Data/DataState/read_ayah_provider.dart';
import '../../Data/DataState/read_error_text_provider.dart';
import '../widgets/save_draft_button.dart';
import '/Features/Assembly/Presentation/State/recited_ayah_by_user.dart';
import '../../Application/Usecases/ai_reading_usercase_implemented.dart';
import '../widgets/restart_quran.dart';
import '../widgets/mic_design.dart';
import '/Features/Assembly/Presentation/State/radio_button_provider.dart';
import '/Features/Assembly/Presentation/State/dropdown_provider.dart';
import '/Features/Assembly/Presentation/State/who_begins_provider.dart';
import '../../../core/Widgets/icon_design.dart';
import '/Features/Assembly/Presentation/State/surah_names_provider.dart';
import '/Features/Assembly/Presentation/State/ayan_state_provider.dart';
import '../widgets/radio_button.dart';
import '/config/themes/theme_manager_provider.dart';

class NewAssemblyScreen extends ConsumerWidget {
  final AIReadingQuranAyahUsecaseImplemented _implemented =
      AIReadingQuranAyahUsecaseImplemented();

  handleWeatherCompeletingDraftSubac(WidgetRef ref, BuildContext context) {
    if (ref.read(whoBeginsQuranReading) == 1 &&
        ref.read(completeStateProvider) == 1) {
      _implemented.aiReadingQuranAyahUseCase(
        recongnizedWords: "",
        ref: ref,
        personTurn: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    handleWeatherCompeletingDraftSubac(ref, context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        centerTitle: true,
        leading: ref.watch(readyCurrentAyahProvider) == 1 ||
                ref.watch(playErrorTextProvider) == 1 ||
                ref.watch(micListeningProvider)
            ? Container()
            : BackButton(
                color: Colors.white,
                onPressed: () {
                  ref.read(nextAyahIndexProvider.notifier).resetAyah();
                  ref.read(whoBeginsQuranReading.notifier).resetWhoBegins();
                  context.pop();
                },
              ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 2.0,
        title: Text("New Assembly"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Image(image: AssetImage("lib/core/images/kitab.png")),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    RadioButtonDesign(
                      title: "By Surah",
                      radioButtonValue: 0,
                    ),
                    RadioButtonDesign(
                      title: "By Hizb",
                      radioButtonValue: 1,
                    ),
                    RadioButtonDesign(
                      title: "By Juz",
                      radioButtonValue: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              DropdownButton2<String>(
                barrierColor: Colors.transparent,
                barrierDismissible: true,
                alignment: AlignmentDirectional.center,
                buttonStyleData: ButtonStyleData(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 49, 202, 169),
                    )),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: 20,
                    ),
                items: ref.watch(radioButtonProvider) == 1 ||
                        ref.watch(radioButtonProvider) == 2
                    ? []
                    : ref.watch(surahNamesProvider).map((eachElement) {
                        return DropdownMenuItem(
                          child: Text(
                            eachElement,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          value: eachElement,
                        );
                      }).toList(),
                onChanged: (ValueOfTabbedMenuItem) {
                  if (ref.read(nextAyahIndexProvider) == 0) {
                    ref
                        .read(dropDownProvider.notifier)
                        .update((state) => ValueOfTabbedMenuItem!);
                    ref.read(nextAyahIndexProvider.notifier).resetAyah();
                  }
                },
                value: ref.watch(dropDownProvider),
              ),
              if (ref.watch(whoBeginsQuranReading) == 0) SizedBox(height: 30),
              if (ref.watch(whoBeginsQuranReading) == 0)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Who Begins",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 20,
                        color: ref.read(themeManagerProvider) == ThemeMode.light
                            ? Colors.black
                            : Colors.white),
                  ),
                ),
              if (ref.watch(whoBeginsQuranReading) == 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (ref.read(whoBeginsQuranReading) == 0) {
                          ref
                              .read(whoBeginsQuranReading.notifier)
                              .aiWillBeginState();
                          ref.read(nextAyahIndexProvider.notifier).resetAyah();
                          ref
                              .read(recitedAyahByUser.notifier)
                              .update((state) => "");
                          _implemented.aiReadingQuranAyahUseCase(
                              
                              ref: ref,
                              recongnizedWords: "",
                              personTurn: 1);
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ref.watch(whoBeginsQuranReading) == 1
                              ? Colors.red
                              : Color.fromARGB(255, 49, 202, 169),
                        ),
                        child: Center(
                          child: Text(
                            "AI",
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    GestureDetector(
                      onTap: () {
                        if (ref.read(whoBeginsQuranReading) == 0) {
                          ref
                              .read(whoBeginsQuranReading.notifier)
                              .userWillBeginState();

                          ref.read(nextAyahIndexProvider.notifier).resetAyah();
                          ref
                              .read(recitedAyahByUser.notifier)
                              .update((state) => "");
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ref.watch(whoBeginsQuranReading) == 2
                              ? Colors.red
                              : Color.fromARGB(255, 49, 202, 169),
                        ),
                        child: Center(
                          child: Text(
                            "Me",
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 20),
              if (ref.watch(playErrorTextProvider) == 2) RestartQuran(),
              if (ref.watch(readyCurrentAyahProvider) == 0 &&
                  ref.watch(playErrorTextProvider) != 2 &&
                  ref.watch(whoBeginsQuranReading) != 0 &&
                  ref.watch(playErrorTextProvider) == 0)
                MicDesign(),
              if (ref.watch(readyCurrentAyahProvider) == 1 ||
                  ref.watch(playErrorTextProvider) == 1)
                SizedBox(
                  height: 100,
                  width: 100,
                  child: LoadingIndicator(
                    indicatorType: Indicator.lineScalePulseOutRapid,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withOpacity(0.6)
                    ],
                  ),
                ),
                
              SizedBox(height: 20),
              if (ref
                          .watch(playErrorTextProvider.notifier)
                          .countNumberOfTimeUserRecitedWrongAyah ==
                      2 &&
                  ref.watch(playErrorTextProvider) == 1)
                Icon(
                  Icons.arrow_downward,
                  color: Colors.green,
                  size: 40,
                ),
              if (ref
                          .watch(playErrorTextProvider.notifier)
                          .countNumberOfTimeUserRecitedWrongAyah ==
                      2 &&
                  ref.watch(playErrorTextProvider) == 1)
                FittedBox(
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                    child: Text(
                      "Yes Surah Name is :${ref.read(dropDownProvider)} with ayah no :${ref.read(nextAyahIndexProvider)}",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontSize: 16,
                          color:
                              ref.watch(themeManagerProvider) == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black),
                    ),
                  ),
                ),
            
              if (ref.watch(readyCurrentAyahProvider) == 1 ||
                  ref.watch(readyCurrentAyahProvider) == 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => ref
                          .read(readyCurrentAyahProvider.notifier)
                          .reWindAudio(),
                      child: ContainerIconHolder(
                        containerBackground: Colors.red,
                        buttonBackgroundColor: Colors.white,
                        typeIcon: Icons.fast_rewind_outlined,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(readyCurrentAyahProvider.notifier)
                            .pauseOrResumseCurrentAyah();
                      },
                      child: ContainerIconHolder(
                        containerBackground: Color.fromARGB(255, 49, 202, 169),
                        buttonBackgroundColor: Colors.white,
                        typeIcon: ref.watch(readyCurrentAyahProvider) == 1
                            ? Icons.stop
                            : Icons.play_arrow_outlined,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => ref
                          .read(readyCurrentAyahProvider.notifier)
                          .fastForwardAudio(),
                      child: ContainerIconHolder(
                        containerBackground: Colors.yellow,
                        buttonBackgroundColor: Colors.white,
                        typeIcon: Icons.fast_forward,
                      ),
                    ),
                  ],
                ),
              if (ref.watch(readyCurrentAyahProvider) == 2)
                SizedBox(height: 30),
              if (ref.watch(readyCurrentAyahProvider) == 2) SaveDraftSubac(),
            ],
          ),
        ),
      ),
    );
  }
}
