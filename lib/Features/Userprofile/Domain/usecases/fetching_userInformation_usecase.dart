import 'package:dartz/dartz.dart';

import '../../../Authentication/core/Erros/auth_error_handling.dart';

abstract class FetchingUserInformationUseCase {
  Future<Either<AuthErrorHandling, Map<String, String>>>
      fetchUserCredialsUseCase();
}
