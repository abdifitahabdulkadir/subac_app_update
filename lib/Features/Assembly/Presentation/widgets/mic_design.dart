import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

// custom imports
import '../../Application/Usecases/ai_reading_usercase_implemented.dart';
import '../State/recited_ayah_by_user.dart';
import '/Features/Assembly/Presentation/State/mic_listening_provider.dart';

class MicDesign extends ConsumerStatefulWidget {
  @override
  ConsumerState<MicDesign> createState() => _MicDesignState();
}

class _MicDesignState extends ConsumerState<MicDesign> {
  AIReadingQuranAyahUsecaseImplemented _implemented =
      AIReadingQuranAyahUsecaseImplemented();
  late SpeechToText speechToText;
  String _collectRecognizedWords = "";
  @override
  void initState() {
    super.initState();
    speechToText = SpeechToText();
    _init();
  }

  void _init() async {
    await speechToText.initialize();
  }

  @override
  void dispose() {
    speechToText.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) async {
        ref.read(micListeningProvider.notifier).update((state) => true);
        if (ref.read(micListeningProvider)) {
          speechToText.locales();
          await speechToText.listen(
            localeId: "ar",
            listenFor: Duration(minutes: 6),
            onResult: (result) {
              setState(() {
                ref.read(recitedAyahByUser.notifier).update(
                      (state) => result.recognizedWords,
                    );
                print(result.recognizedWords);
              });
            },
          );
        }
      },
      onLongPressEnd: (details) async {
        ref.read(micListeningProvider.notifier).update((state) => false);
        speechToText.stop();
        await _implemented.aiReadingQuranAyahUseCase(
            recongnizedWords: ref.read(recitedAyahByUser),
            ref: ref,
            context: context,
            personTurn: 1);
      },
      child: AvatarGlow(
        child: Icon(
          ref.watch(micListeningProvider) ? Icons.mic : Icons.mic_off,
          size: 30,
        ),
        animate: ref.watch(micListeningProvider),
        showTwoGlows: true,
        duration: Duration(milliseconds: 2000),
        endRadius: 80.5,
        repeat: true,
        repeatPauseDuration: Duration(milliseconds: 100),
      ),
    );
  }
}
