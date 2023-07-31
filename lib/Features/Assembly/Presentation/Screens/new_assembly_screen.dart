import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';

// my custom imports
import '/Features/Assembly/Data/Remote_source/read_ayah_provider.dart';
import '/Features/Assembly/Data/Remote_source/read_error_text_provider.dart';
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

class NewAssemblyScreen extends ConsumerWidget {
  final AIReadingQuranAyahUsecaseImplemented _implemented =
      AIReadingQuranAyahUsecaseImplemented();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: Colors.white,
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
                        ),
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
                              .update((state) => 1);
                          ref.read(nextAyahIndexProvider.notifier).resetAyah();
                          ref
                              .read(recitedAyahByUser.notifier)
                              .update((state) => "");
                          _implemented.aiReadingQuranAyahUseCase(
                              context: context,
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
                              .update((state) => 2);
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
                    indicatorType: Indicator.audioEqualizer,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary.withOpacity(0.6)
                    ],
                  ),
                ),
              SizedBox(height: 20),
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
                            .pauseCurrentAyah();
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
