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
      required int personTurn}) async {
    return await _implemented.aiReadingRepository(
      recongnizedWords: recongnizedWords,
      ref: ref,
      personTurn: personTurn,
    );
  }
}
