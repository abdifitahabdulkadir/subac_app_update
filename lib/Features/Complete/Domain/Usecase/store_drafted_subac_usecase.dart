import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class StoreDraftedSubacUsecase {
  Future<void> storeDraftedUseCase({
    required String surahName,
    required int ayahNumber,
    required DateTime dateTime,
    required int surahAyahLength,
    required WidgetRef ref,
  });
}
