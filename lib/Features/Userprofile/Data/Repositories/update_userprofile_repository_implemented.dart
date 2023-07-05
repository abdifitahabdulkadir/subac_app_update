import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:subac_app_update/Features/Userprofile/Domain/entities/image_update_entity.dart';
import '../../Domain/repositiories/update_userimage_repository.dart';
import '/Features/Authentication/core/Erros/auth_error_handling.dart';

class UpdateUserImageRepositoryImplemented
    implements UpdateUserImageRepository {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<Either<AuthErrorHandling, bool>> updateUserImage(
      {required ImageUpdateEntity imageUpdateEntity}) async {
    bool isErrorHappend = false;
    String errorMessage = "";
    try {
      final storagePath = await _firebaseStorage
          .ref()
          .child("userimages")
          .child("${_firebaseAuth.currentUser!.uid} png");

      // add file to the specified path
      await storagePath.putFile(imageUpdateEntity.imageFile);

      // updating user profile link in firestore
      _firebaseFirestore
          .collection("userinformation")
          .where("userid", isEqualTo: _firebaseAuth.currentUser!.uid)
          .get()
          .then((value) {
        value.docs.forEach((element) async {
          await _firebaseFirestore
              .collection("userinformation")
              .doc(element.id)
              .update({"profile_url": await storagePath.getDownloadURL()});
          isErrorHappend = false;
        });
      });
      print("wala yimid luuuqa danbe");
    } catch (exception) {
      isErrorHappend = true;
      errorMessage = exception.toString();
    }
    return isErrorHappend
        ? Left(AuthErrorHandling(errorMessage: errorMessage))
        : right(isErrorHappend);
  }
}
