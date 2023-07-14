import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subac_app_update/Features/Assembly/Domain/Entities/surah_entitiy.dart';

class SurahNamesNotifier extends StateNotifier<List<SurahEntity>> {
  SurahNamesNotifier()
      : super([SurahEntity(surahName: "Surah", surahNumber: -1)]);

  addSurahNames({required SurahEntity surahEnitty}) {
    state = [...state, surahEnitty];
  }
}

final surahInformationProvider =
    StateNotifierProvider<SurahNamesNotifier, List<SurahEntity>>(
        (ref) => SurahNamesNotifier());
