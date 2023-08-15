import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
* state ==0 -- means it is default value which is 0.
* it is my way of doing it to make state ==0 so 
* i can understand while errorText  or *compeletion text words is  not playing
* is not playing or c. 
* 
* state ==1 -- means ErrorText is playing and i has called function one to read and
* maintain state from 0 to 1 to show user loading indicator that sound is playing back. 
* It is again my own way of differentiating states.
* 
* state==2 -- means when the second method is called and reads completion task
* and that time we need to show user resetStart button to restart again incase
* he want after compeletion of playing compeletion text and to trigger UI build method.
*so we need to another provider to update it's state so that resstart will watch and 
* it can trigger UI with help of watch function but it is tooo cost and can use
* bad state and related exception and that is why I marked state==2 to know that is the 
* time for when I have to show user restart Buttton.
* again It is my own way of differentiating which state that audio currently is.

* I am using all these 3 states in just one StateNotifier 
* riverpod class to avoid too much  composing of 
* riverpod in just simple these three correlating states.
*/

class ReadErrorTextNotifier extends StateNotifier<int> {
  ReadErrorTextNotifier() : super(0);
  int countNumberOfTimeUserRecitedWrongAyah = 0;
  late Audio _audioPlay;

  /* 
  * playing the error sound when user recites wrong ayah than it is suppose to read
  */
  Future<void> palyErrorForWrongAyah(
      {required String surahName,
      required int ayahNumber,
      required WidgetRef ref}) async {
    countNumberOfTimeUserRecitedWrongAyah++;
    state = 1;

    //handling  first time use reads wrong ayah at his turn
    if (countNumberOfTimeUserRecitedWrongAyah == 1) {
      try {
        _audioPlay = await Audio.load("assets/error_audio/first_wrong_time.mp3",
            onComplete: () {
          state = 0;
        })
          ..play();
      } catch (exception) {}
    }

    // handling second time user reads wrong ayah at his turn
    else if (countNumberOfTimeUserRecitedWrongAyah == 2) {
      try {
        _audioPlay = await Audio.load("assets/error_audio/Second_Time.mp3",
            onComplete: () {
          state = 0;
        })
          ..play();
      } catch (exception) {}
    }
  }

  /*
  *this method only plays sound erro when user clicks (me button)- that is wil start the taking turn at first  *time but reads nothing then we will call this function and it will repeatedly call if he again reads nothing
  * or AI does not understand compelete words of user -- due to noise, bad network, device mic and more.
  */
  Future<void> palyErrorSoundAfterUserTurnReadsNothing() async {
    state = 1;
    try {
      _audioPlay = await Audio.load(
          "assets/error_audio/after_user_reads_nothing.mp3", onComplete: () {
        state = 0;
      })
        ..play();
    } catch (exception) {}
  }

/*
*plying the error sound when user finishes or takes last ayah or 
* Ai takes last ayah then user says some good words like thank -as expected.
*/
  Future<void> readEndsWords() async {
    state = 1;
    try {
      _audioPlay =
          await Audio.load("assets/error_audio/subac_end.mp3", onComplete: () {
        state = 2;
      })
            ..play();
    } catch (exception) {}
  }

/*
* it resets the provider with default value of 0
* and it is import to use because there are some widgets watching this and
* we want to update them by changing the state otherwise 
* uncessary state is shown on screen.
*/
  resetPlayErrorProvider() {
    state = 0;
    countNumberOfTimeUserRecitedWrongAyah = 0;
  }

  /*
  * restes to 0 number of times user has recited wrong ayah to take decision
  * weather he recites another ayah in wrong way
  */
  resetNumberOfTimesUserRecitedWrongAyah() {
    countNumberOfTimeUserRecitedWrongAyah = 0;
  }
}

final playErrorTextProvider =
    StateNotifierProvider.autoDispose<ReadErrorTextNotifier, int>(
        (ref) => ReadErrorTextNotifier());
