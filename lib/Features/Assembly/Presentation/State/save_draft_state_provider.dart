import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Complete/Application/Usescases/store_draftedsubac_usecase_imple.dart';

class SaveDraftNotifier extends StateNotifier<int> {
  SaveDraftNotifier() : super(0);
  StoreDraftedSubacUsecaseImple _draftedSubacUsecaseImple =
      StoreDraftedSubacUsecaseImple();
  /*
  * saving data by sending to firebase and managing the 
  * stae of button into loading to show user that storing data is in process
  */

  Future<void> storeDraftData(
      {required String surahName,
      required int ayahNumber,
      required WidgetRef ref,
      required int surahAyahLength,
      required DateTime datetime}) async {
    state = 1;
    await _draftedSubacUsecaseImple.storeDraftedUseCase(
        surahName: surahName,
        ayahNumber: ayahNumber,
        dateTime: datetime,
        surahAyahLength: surahAyahLength,
        ref: ref);
    state = 0;
  }
}

final saveDraftSubacProvider =
    StateNotifierProvider<SaveDraftNotifier, int>((ref) => SaveDraftNotifier());
