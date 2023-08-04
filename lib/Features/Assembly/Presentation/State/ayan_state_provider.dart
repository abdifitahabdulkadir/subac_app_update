import 'package:flutter_riverpod/flutter_riverpod.dart';

class AyahStateNotifier extends StateNotifier<int> {
  AyahStateNotifier() : super(0);

  // update the logic
  void incrementToNextAyah() {
    state++;
  }

// reset ayah to sate =0
  void resetAyah() {
    print("zeeeor");
    state = 0;
  }

  //adjust ayah to complete again
  void adjustAyahState({required int ayahNumber}) {
    state = ayahNumber;
  }
}

final nextAyahIndexProvider =
    StateNotifierProvider<AyahStateNotifier, int>((ref) => AyahStateNotifier());
