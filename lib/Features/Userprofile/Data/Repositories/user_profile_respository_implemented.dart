import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

// my own imports
import '/Features/Authentication/core/Erros/auth_error_handling.dart';
import '/Features/Userprofile/Domain/entities/user_entity.dart';
import '../../Domain/repositiories/user_profile_repository.dart';

class UserProfileRepositoryImplemented implements UserProfileRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  String _documentId = "";

  @override
  Future<Either<AuthErrorHandling, void>> updateUserInformation(
      {required UserEntity userEntity}) async {
    String errorMessagae = "";
    bool isErrorHappend = false;
    String documentId = "";
    try {
      await _fireStore
          .collection("userinformation")
          .where("userid", isEqualTo: _firebaseAuth.currentUser!.uid)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if (_firebaseAuth.currentUser!.uid == element.data()["userid"]) {
           
            _documentId = element.id;
            isErrorHappend = false;
          }
        });
      });
      await _fireStore.collection("userinformation").doc(_documentId).update({
        "name": userEntity.name,
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
