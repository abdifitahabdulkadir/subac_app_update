/*
* holds surahAyah length provider
*/
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SurahAyahLengthNotifier extends StateNotifier<int> {
  SurahAyahLengthNotifier() : super(0);

  /* 
  * resgiter current surah ayah lenght
  */
  void registerCurrentAyahSurahLength({required int ayahLength}) {
    state = ayahLength;
  }

  /* 
  * reset ayah length to 0
  */
  void resetSurahLengthState() {
    state = 0;
  }
}

final surahAyahLengthProvider =
    StateNotifierProvider<SurahAyahLengthNotifier, int>(
        (ref) => SurahAyahLengthNotifier());
