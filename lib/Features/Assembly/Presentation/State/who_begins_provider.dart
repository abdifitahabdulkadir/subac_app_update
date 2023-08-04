import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
* by default the user will start the quran reading by 
* you can simpy tweek by toggling the switch button
*/
class WhoBeginsStateNotifier extends StateNotifier<int> {
  WhoBeginsStateNotifier() : super(0);

  // reset who begins
  void resetWhoBegins() {
    state = 0;
  }

  // begins with Ai state
  void aiWillBeginState() {
    state = 1;
  }

  // begins with user state
  void userWillBeginState() {
    state = 2;
  }
}

final whoBeginsQuranReading =
    StateNotifierProvider<WhoBeginsStateNotifier, int>(
        (ref) => WhoBeginsStateNotifier());
