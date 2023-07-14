// imports of mine
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/Features/Assembly/Application/state/surah_names_provider.dart';
import 'package:subac_app_update/Features/Assembly/Domain/Entities/surah_entitiy.dart';
import '/Features/Assembly/Domain/Usecases/surah_usercase.dart';
import '../../Data/Repository/surah_repository_implemented.dart';

class SurahUsercaseImplemented implements SurahUserCase {
  SurahRepositoryImplemented _surahRepositoryImplemented =
      SurahRepositoryImplemented();
  @override
  Future<void> fetchSurahInformaitonUserCase({required WidgetRef ref}) async {
    await _surahRepositoryImplemented
        .fetchSurahInformaiton()
        .then((fetchedData) {
      fetchedData.forEach((eachSurah) {
        eachSurah.forEach((everyColumnInSurah) {
          ref.read(surahInformationProvider.notifier).addSurahNames(
                surahEnitty: SurahEntity(
                    surahName: everyColumnInSurah[1],
                    surahNumber: everyColumnInSurah[0]),
              );
        });
      });
    });
  }
}
