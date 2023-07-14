import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// my custom imports
import '../../Application/Usecases/surah_usercase_implemented.dart';
import '/Features/Assembly/Presentation/State/dropdown_provider.dart';
import '/Features/Assembly/Presentation/State/who_begins_provider.dart';
import '../../../core/Widgets/icon_design.dart';
import '/Features/Assembly/Application/state/surah_names_provider.dart';
import '../widgets/radio_button.dart';

class NewAssemblyScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<NewAssemblyScreen> createState() => _NewAssemblyScreenState();
}

class _NewAssemblyScreenState extends ConsumerState<NewAssemblyScreen> {
  SurahUsercaseImplemented _implemented = SurahUsercaseImplemented();
  @override
  void initState() {
    super.initState();
    _implemented.fetchSurahInformaitonUserCase(ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(color: Colors.white),
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
              SizedBox(
                height: 25,
              ),
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
                items: ref.watch(surahInformationProvider).map((eachElement) {
                  return DropdownMenuItem(
                    child: Text(
                      eachElement.surahName,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    value: eachElement.surahName,
                  );
                }).toList(),
                onChanged: (ValueOfTabbedMenuItem) {
                  ref.read(dropDownProvider.notifier).update((state) =>
                      ValueOfTabbedMenuItem ??
                      ref.read(surahInformationProvider)[1].surahName);
                },
                value: ref.watch(dropDownProvider),
              ),
              SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Who Begins",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 20,
                      ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 49, 202, 169),
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
                  SizedBox(width: 50),
                  Transform.scale(
                      scale: 2,
                      child: Switch(
                          activeColor: Colors.red,
                          value: ref.watch(whoBeginsQuranReading),
                          onChanged: (value) => ref
                              .read(whoBeginsQuranReading.notifier)
                              .update((state) => value))),
                  SizedBox(width: 50),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 49, 202, 169),
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
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Start",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 49, 202, 169),
                  fontStyle: FontStyle.italic,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6),
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 49, 202, 169),
                  ),
                  child: Center(child: Text("Audio will be here ")),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ContainerIconHolder(
                    containerBackground: Colors.red,
                    buttonBackgroundColor: Colors.white,
                    typeIcon: Icons.pause,
                  ),
                  ContainerIconHolder(
                    containerBackground: Color.fromARGB(255, 49, 202, 169),
                    buttonBackgroundColor: Colors.white,
                    typeIcon: Icons.stop,
                  ),
                  ContainerIconHolder(
                    containerBackground: Colors.yellow,
                    buttonBackgroundColor: Colors.white,
                    typeIcon: Icons.check,
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
