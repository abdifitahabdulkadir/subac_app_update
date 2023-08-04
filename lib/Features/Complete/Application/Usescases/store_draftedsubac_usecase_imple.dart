import 'package:flutter_riverpod/flutter_riverpod.dart';

// imports
import '/Features/Complete/Domain/Usecase/store_drafted_subac_usecase.dart';
import '../../Data/Respository/store_draftedSubac_repso_imple.dart';

class StoreDraftedSubacUsecaseImple implements StoreDraftedSubacUsecase {
  StoreDraftedSubacRepositoryImple _implemented =
      StoreDraftedSubacRepositoryImple();
  @override
  Future<void> storeDraftedUseCase({
    required String surahName,
    required int ayahNumber,
    required DateTime dateTime,
    required int surahAyahLength,
    required WidgetRef ref,
  }) {
    return _implemented.storeDraftedSubacReposity(
      surahName: surahName,
      ayahNumber: ayahNumber,
      dateTime: dateTime,
      surahAyahLength: surahAyahLength,
      ref: ref,
    );
  }
}
