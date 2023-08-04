import 'package:flutter_riverpod/flutter_riverpod.dart';

// custom imports
import '/Features/Complete/Domain/Repository/store_drafted_subac_repository.dart';
import '../Remote/store_draftedsubac.dart';

class StoreDraftedSubacRepositoryImple implements StoreDraftedSubacRepository {
  @override
  Future<void> storeDraftedSubacReposity({
    required String surahName,
    required int ayahNumber,
    required DateTime dateTime,
    required int surahAyahLength,
    required WidgetRef ref,
  }) {
    return storeDraftedSubacInFirebase(
      ayahNumber: ayahNumber,
      surahName: surahName,
      ref: ref,
      dateTime: dateTime,
      surahAyahLength: surahAyahLength,
    );
  }
}
