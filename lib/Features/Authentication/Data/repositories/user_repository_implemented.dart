import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

// my imports
import '../../../../Features/Authentication/Domain/entities/login_user.dart';
import '../../../../Features/Authentication/Domain/entities/register_user.dart';
import '../../Domain/repositories/user_repository.dart';
import '../../core/Erros/auth_error_handling.dart';
import '/Features/Authentication/Data/state/firebase_instance_providers.dart';

class UserRepositoryImplemented implements UserRepository {
  final _userDefaultImageProfileLink =
      "https://w7.pngwing.com/pngs/831/88/png-transparent-user-profile-computer-icons-user-interface-mystique-miscellaneous-user-interface-design-smile.png";
  @override
  Future<Either<AuthErrorHandling, UserCredential>> loginUser(
      {required LoginUserEntity loginUserEntity}) async {
    String message = "";
    try {
      final getCredianls = await firebasAuthInstance.signInWithEmailAndPassword(
          email: loginUserEntity.email, password: loginUserEntity.password);
      if (getCredianls.user != null) {
        return Right(getCredianls);
      }
    } catch (exception) {
      message = exception.toString();
    }
    return left(AuthErrorHandling(errorMessage: message));
  }

  @override
  Future<Either<AuthErrorHandling, UserCredential>> registerUser(
      {required RegisterUserEntity registerUserEntity}) async {
    String message = "";
    try {
      final getUserCredials =
          await firebasAuthInstance.createUserWithEmailAndPassword(
              email: registerUserEntity.userEmail,
              password: registerUserEntity.password);

      final _getDocumentRefernce =
          await firestoreInstace.collection("userinformation").add({
        "email": registerUserEntity.userEmail,
        "name": registerUserEntity.username,
        "password": registerUserEntity.password,
        "userid": getUserCredials.user!.uid,
        "profile_url": _userDefaultImageProfileLink,
      });
      if (_getDocumentRefernce.id.isNotEmpty) {
        return Right(getUserCredials);
      }
    } catch (exception) {
      message = exception.toString();
    }
    return Left(AuthErrorHandling(errorMessage: message));
  }
}
