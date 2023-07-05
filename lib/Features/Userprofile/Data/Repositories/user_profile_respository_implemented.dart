import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/Features/Authentication/core/Erros/auth_error_handling.dart';
import '/Features/Userprofile/Domain/entities/user_entity.dart';
import '../../Domain/repositiories/user_profile_repository.dart';

class UserProfileRepositoryImplemented implements UserProfileRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  String _documentId = "";
  @override
  Future<Either<AuthErrorHandling, Map<String, String>>>
      fetchUserCredials() async {
    String username = "";
    String email = "";
    String errorMessage = "";
    bool isErrorHappend = false;
    try {
      await _fireStore
          .collection("userinformation")
          .where("userid", isEqualTo: _firebaseAuth.currentUser!.uid)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if (_firebaseAuth.currentUser!.uid == element.data()["userid"]) {
            username = element.data()["name"];
            email = element.data()["email"];
            _documentId = element.id;
            isErrorHappend = false;
          }
        });
      });
    } on FirebaseAuthException catch (exception) {
      errorMessage = exception.toString();
      isErrorHappend = true;
    }
    return isErrorHappend
        ? Left(AuthErrorHandling(errorMessage: errorMessage))
        : right({
            "name": username,
            "email": email,
          });
  }

  @override
  Future<Either<AuthErrorHandling, void>> updateUserInformation(
      {required UserEntity userEntity}) async {
    await fetchUserCredials();
    String errorMessagae = "";
    bool isErrorHappend = false;
    try {
      print("updating information");
      print(userEntity.name);
      print(userEntity.email);
      print("our id $_documentId");
      await _fireStore.collection("userinformation").doc(_documentId).update({
        "name": userEntity.name,
        "email": userEntity.email,
      });
      isErrorHappend = false;
    } catch (exception) {
      errorMessagae = exception.toString();
      isErrorHappend = true;
    }
    return isErrorHappend
        ? Left(AuthErrorHandling(errorMessage: errorMessagae))
        : right(null);
  }
}
