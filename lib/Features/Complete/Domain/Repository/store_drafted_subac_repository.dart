import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class StoreDraftedSubacRepository {
  Future<void> storeDraftedSubacReposity({
    required String surahName,
    required int ayahNumber,
    required DateTime dateTime,
    required int surahAyahLength,
    required WidgetRef ref,
  });
}
