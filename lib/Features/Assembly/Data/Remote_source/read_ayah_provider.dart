import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
* state ==1 -- means audio is playing currently we can pause, rewind and fastforwardas.
* it is my way of doing it to make state ==1 so i can understand while audio is playing. 
* 
* state ==0 -- means neither audio is playing nor has been 
* paused and need to resume but it is audio has completed anyway.
* it is again my own way of differentiating weather audio has completed nor not.
* 
* state==2 -- means audio is paused and need to resume and you can also rewind and fastword.
* again ti is my own way of differentiating which state that audio currently is.

* I am using all these 3 states in just one StateNotifier riverpod class to avoid too much composing of 
* riverpod in just simple these three correlating states.
*/
class ReadAyahNotifier extends StateNotifier<int> {
  ReadAyahNotifier() : super(0);
  Audio? audio = null;
  double getCurrentPosition = 0;

/*
* loading and reading the current ayah
*/
  Future<void> playAyah(
      {required ayahPath, required WidgetRef ref, required ayahLength}) async {
    state = 1;
    // Load from assets, store as a variable.
    audio = await Audio.load('assets/audio/${ayahPath}.mp3', onComplete: () {
      state = 0;
    }, onPosition: (double currentPosiotn) {
      getCurrentPosition = currentPosiotn;
    })
      ..play();
  }

  /*
  * pausing the ayah in progress or now playing in the backgorund
  */
  Future<void> pauseCurrentAyah() async {
    if (state == 1 && audio != null) {
      await audio!.pause();

      state = 2;
    } else if (state == 2 && audio != null) {
      state = 1;
      await audio!.resume();
    }
  }

  /*
  * this method is responsible for rewind the audio back to 2 seconds or 2000 ms.
  *seek functon takes positon to seek in secons 
  * and that is why I have  substracted explictlly 2.
  */
  Future<void> reWindAudio() async {
    if (state == 1 || state == 2 && audio != null) {
      try {
        await audio!.seek(getCurrentPosition - 2);
      } catch (e) {}
    }
  }

  /*
  *  
  * this method is responsible for forwading the audio  to 2 seconds or 2000 ms.
  * seek functon takes positon to seek in secons and that is why I have added explictlly 2.
  */
  Future<void> fastForwardAudio() async {
    if (state == 1 || state == 2 && audio != null) {
      try {
        await audio!.seek(getCurrentPosition + 2);
      } catch (e) {}
    }
  }
}

final readyCurrentAyahProvider =
    StateNotifierProvider.autoDispose<ReadAyahNotifier, int>(
        (ref) => ReadAyahNotifier());
