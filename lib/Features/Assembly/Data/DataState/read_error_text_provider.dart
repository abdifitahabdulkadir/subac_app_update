import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

// custom import
import '../constants/constants_text.dart';

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
FlutterTts _textToSpeech = FlutterTts();

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
    //
    //hadnling thes stuff initialization before hand

    _textToSpeech.setLanguage("en");
    _textToSpeech.setSpeechRate(0.4);
    _textToSpeech.stop();

    countNumberOfTimeUserRecitedWrongAyah++;
    if (countNumberOfTimeUserRecitedWrongAyah == 3)
      countNumberOfTimeUserRecitedWrongAyah = 1;
    state = 1;

    //handling  first time use reads wrong ayah at his trn
    if (countNumberOfTimeUserRecitedWrongAyah == 1) {
      try {
        await _textToSpeech.speak(textAfterUserRecitesWrongAyahFirstTime);
        _textToSpeech.setCompletionHandler(() {
          state = 0;
          print("state waa  ee iska eeeg : ${state}");
          _textToSpeech.stop();
        });
      } catch (exception) {
        print("error aya dhacay : ${exception}");
      }
    }

    // handling second time user reads wrong ayah at his turn
    else if (countNumberOfTimeUserRecitedWrongAyah == 2) {
      await _textToSpeech.speak(textAfterUserRecitesWrongAyahSecondTime);
      _textToSpeech.setCompletionHandler(
          () => _readHints(ayahNumber: ayahNumber, surahName: surahName));
    }
  }

  /*
  * this is the method for responsible reading of hint only for second time
  *a nd third time user recites wrong ayah.
  */
  Future<void> _readHints(
      {required String surahName, required int ayahNumber}) async {
    var hintText =
        "Le me give a hint  : now I gonna tell both surah name and ayah number of this surah that it is suppose you to take in your turn okie Surah name is ${surahName} ayahNumber ${ayahNumber}";
    if (countNumberOfTimeUserRecitedWrongAyah == 2) {
      await _textToSpeech.speak(hintText);
      _textToSpeech.setCompletionHandler(() {
        state = 0;
        _textToSpeech.stop();
      });
    }
  }

/*
*plying the error sound when user finishes or takes last ayah or 
* Ai takes last ayah then user says some good words like thank -as expected.
*/
  Future<void> readEndsWords({required String textToBeRead}) async {
    state = 1;

    _textToSpeech.setLanguage("en");
    try {
      await _textToSpeech.speak(textToBeRead);
      _textToSpeech.setCompletionHandler(() {
        state = 2;
        countNumberOfTimeUserRecitedWrongAyah = 0;
        _textToSpeech.stop();
      });
    } catch (excepton) {
      print(excepton);
    }
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

  /*
  *this method only plays sound erro when user clicks (me button)- that is wil start the taking turn at first  *time but reads nothing then we will call this function and it will repeatedly call if he again reads nothing
  * or AI does not understand compelete words of user -- due to noise, bad network, device mic and more.
  */

  Future<void> palyErrorSoundAfterUserTurnReadsNothing(
      {required String textToBeRead}) async {
    state = 1;
    _textToSpeech.setLanguage("en");
    await _textToSpeech.speak(textToBeRead);
    _textToSpeech.setCompletionHandler(() {
      state = 2;
      _textToSpeech.stop();
    });
  }
}

final playErrorTextProvider =
    StateNotifierProvider.autoDispose<ReadErrorTextNotifier, int>(
        (ref) => ReadErrorTextNotifier());
