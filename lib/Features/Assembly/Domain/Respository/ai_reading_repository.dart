import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AIReadingRepository {
  Future<void> aiReadingRepository(
      {required String recongnizedWords,
      required WidgetRef ref,
      required BuildContext context,
      required int personTurn});
}
