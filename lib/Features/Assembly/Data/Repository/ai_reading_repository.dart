import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Domain/Respository/ai_reading_repository.dart';
import '../Remote_source/ai_reaidng.dart';

class AIReadingAyahRepositoryImplemented implements AIReadingRepository {
  @override
  Future<void> aiReadingRepository(
      {required String recongnizedWords,
      required WidgetRef ref,
    required int personTurn,
  }) async {
    return await aiReadingAyah(
      ref: ref,
      reconizedWords: recongnizedWords,
      personTurn: personTurn,
    );
  }
}
