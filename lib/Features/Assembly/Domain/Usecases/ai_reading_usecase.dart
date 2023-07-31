import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AIReadingQuranAyahUseCase {
  Future<void> aiReadingQuranAyahUseCase(
      {required String recongnizedWords,
      required WidgetRef ref,
      required BuildContext context,
      required int personTurn});
}
