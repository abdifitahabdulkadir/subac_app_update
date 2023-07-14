import 'package:dartz/dartz.dart';
import '/Features/Assembly/Domain/Respository/surah_respository.dart';
import '/Features/Authentication/core/Erros/auth_error_handling.dart';

import '../Remote_source/connect_postgress.dart';

class SurahRepositoryImplemented implements SurahRepsitory {
  @override
  Future<Either<AuthErrorHandling, List<List<dynamic>>>>
      fetchSurahInformaiton() async {
    print("way la imaady hdan ahy surharepsotiy implemented");
    return await fetchSurahInformationFromDatabase();
  }
}
