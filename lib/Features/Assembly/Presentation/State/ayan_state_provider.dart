import 'package:flutter_riverpod/flutter_riverpod.dart';

class AyahStateNotifier extends StateNotifier<int> {
  AyahStateNotifier() : super(0);

  // update the logic
  void incrementToNextAyah() {
    state++;
  }

  void resetAyah() {
    print("zeeeor");
    state = 0;
  }
}

final nextAyahIndexProvider =
    StateNotifierProvider<AyahStateNotifier, int>((ref) => AyahStateNotifier());
