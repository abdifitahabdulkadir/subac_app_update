import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

/*
* state ==0 -- means it is default value which is 0.
* it is my way of doing it to make state ==0 so 
* i can understand while errorText  or *compeletion text words is  not playing
* is not playing or c. 
* 
* state ==1 -- means ErrorText is playing and i has called function one to read and
* maintain state from 0 to 1 to show user loading indicator that sound is playing back. 
* Ut is again my own way of differentiating states.
* 
* state==2 -- means when the second method is called and reads completion task
* and that time we need to show user resetStart button to restart again incase
* he want after compeletion of playing compeletion text and to trigger UI build method
* we need to another provider to update it's state so that resstart will watch and 
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

  Future<void> palyErrorText({required String textToBeRead}) async {
    state = 1;
    await _textToSpeech.speak(textToBeRead);
    _textToSpeech.setCompletionHandler(() {
      state = 0;
      _textToSpeech.stop();
    });
  }

  Future<void> readEndsWords({required String textToBeRead}) async {
    state = 1;
    await _textToSpeech.speak(textToBeRead);
    _textToSpeech.setCompletionHandler(() {
      state = 2;
      _textToSpeech.stop();
    });
  }

/*
* it resets the provider with default value of 0
*/
  resetPlayErrorProvider() {
    state = 0;
  }
}

final playErrorTextProvider = StateNotifierProvider<ReadErrorTextNotifier, int>(
    (ref) => ReadErrorTextNotifier());
