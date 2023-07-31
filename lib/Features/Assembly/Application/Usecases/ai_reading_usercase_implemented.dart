import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Domain/Usecases/ai_reading_usecase.dart';
import '../../Data/Repository/ai_reading_repository.dart';

class AIReadingQuranAyahUsecaseImplemented
    implements AIReadingQuranAyahUseCase {
  AIReadingAyahRepositoryImplemented _implemented =
      AIReadingAyahRepositoryImplemented();
  @override
  Future<void> aiReadingQuranAyahUseCase(
      {required String recongnizedWords,
      required WidgetRef ref,
      required BuildContext context,
      required int personTurn}) async {
    print("our quran is here usercase impleented");
    print(recongnizedWords);
    return await _implemented.aiReadingRepository(
      recongnizedWords: recongnizedWords,
      ref: ref,
      context: context,
      personTurn: personTurn,
    );
  }
}
