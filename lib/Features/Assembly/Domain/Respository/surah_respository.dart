import 'package:dartz/dartz.dart';
import '/Features/Authentication/core/Erros/auth_error_handling.dart';

abstract class SurahRepsitory {
  Future<Either<AuthErrorHandling, List<List<dynamic>>>>
      fetchSurahInformaiton();
}
