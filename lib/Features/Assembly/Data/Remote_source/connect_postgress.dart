import 'package:dartz/dartz.dart';
import 'package:postgres/postgres.dart';
import 'package:postgres_dart/postgres_dart.dart';

// custom imports
import '/Features/Authentication/core/Erros/auth_error_handling.dart';

Future<Either<AuthErrorHandling, List<List<dynamic>>>>
    fetchSurahInformationFromDatabase() async {
  bool _isErrorHappened = false;
  String _errorMessage = "";
  List<List<dynamic>> _surahInformation = [];

  final connectionPostgress = PostgreSQLConnection(
    "10.0.2.2",
    5432,
    "qurandatabase",
    username: "postgres",
    password: "admin",
  );

  await connectionPostgress.open().then((value) async {
    _isErrorHappened = false;
    _surahInformation = await connectionPostgress
        .query("SELECT surah_number, surah_name FROM surah_information");
  }).onError((error, stackTrace) {
    _isErrorHappened = true;
    _errorMessage = error.toString();
  });
  return _isErrorHappened
      ? left(AuthErrorHandling(errorMessage: _errorMessage))
      : Right(_surahInformation);
}
