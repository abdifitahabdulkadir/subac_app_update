import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AIReadingQuranAyahUseCase {
  Future<void> aiReadingQuranAyahUseCase(
      {required String recongnizedWords,
      required WidgetRef ref,
      required int personTurn});
}
