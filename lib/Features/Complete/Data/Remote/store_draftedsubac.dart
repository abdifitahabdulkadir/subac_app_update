import 'package:flutter_riverpod/flutter_riverpod.dart';

// improts
import 'valte_userdocument_existance.dart';
import '/Features/Complete/Data/Remote/create_new_document.dart';
import '/Features/Complete/Data/Remote/update_document.dart';
import '/Features/Complete/Data/Remote/validate_current_document_existance.dart';
import '/config/state/firebase_constants.dart';

Future<void> storeDraftedSubacInFirebase({
  required String surahName,
  required int ayahNumber,
  required DateTime dateTime,
  required WidgetRef ref,
  required int surahAyahLength,
}) async {
  try {
    // check if the user has already had a docuemnt with his userid
    final bool _userAlreadyHasDocument = await isThisUserHasDocumentAlready(
      documentId: ref.read(firebaseAuthInstanceProvider).currentUser!.uid,
      ref: ref,
    );

    // if it is true(user has already had docuemnt) then call fucntion
    // to check weather his sub collection has same docuemnt like this one
    // surahname with ayah numeber
    if (_userAlreadyHasDocument) {
      final bool _isCurrentDocumentExisted = await isDocumentExistedBefore(
        ayahNumber: ayahNumber,
        surahName: surahName,
        ref: ref,
      );

      // if so then upate the exisiting one
      if (_isCurrentDocumentExisted) {
        await updateCurrentDocument(
          documentId: "${surahName}${ayahNumber}",
          surahName: surahName,
          ayahNumber: ayahNumber,
          userid: ref.read(firebaseAuthInstanceProvider).currentUser!.uid,
          datetime: dateTime,
          ref: ref,
          surahAyahLength: surahAyahLength,
        );
      }
      // create new one for him
      else {
        await createNewDocument(
          documentId: "${surahName}${ayahNumber}",
          surahName: surahName,
          ayahNumber: ayahNumber,
          userid: ref.read(firebaseAuthInstanceProvider).currentUser!.uid,
          datetime: dateTime,
          ref: ref,
          surahAyahLength: surahAyahLength,
        );
      }
    }
    // if user does not have  any document with userid then
    // simply create document with id and create subCollection then new documnet
    // with current surah name and ayah--al-fatixa0
    else {
      await createNewDocument(
        documentId: "${surahName}${ayahNumber}",
        surahName: surahName,
        ayahNumber: ayahNumber,
        userid: ref.read(firebaseAuthInstanceProvider).currentUser!.uid,
        datetime: dateTime,
        ref: ref,
        surahAyahLength: surahAyahLength,
      );
    }
  } catch (exception) {
    print(exception.toString());
  }
}
