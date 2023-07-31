import 'package:flutter_riverpod/flutter_riverpod.dart';

final surahNamesProvider = Provider<List<String>>((ref) {
  return [
    "Al-fatixa",
    "AN-nas",
    "Al-falaq",
    "Al-ikhlas",
    "Al-masad",
    "Al-nasr",
    "Al-kafirun",
    "Al-kouthar",
    "Al-fil",
    "Al-maun",
    "Quraish",
    "Al-humazah",
  ];
});
