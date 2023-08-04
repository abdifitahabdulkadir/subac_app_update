// ignore_for_file: unused_local_variable
import 'package:flutter_riverpod/flutter_riverpod.dart';

// my improts
import '../../../../config/state/firebase_constants.dart';
import '../constants/constants.dart';

Future<bool> isDocumentExistedBefore({
  required int ayahNumber,
  required String surahName,
  required WidgetRef ref,
}) async {
  bool _isExisted = false;
  try {
    final _getDocuments = await ref
        .read(firebaseFirebaseInstanceProvider)
        .collection(DraftSubacConstants.collectionName)
        .doc(ref.read(firebaseAuthInstanceProvider).currentUser!.uid)
        .collection(DraftSubacConstants.subCollectionName)
        .get();
    _getDocuments.docs.forEach((eachDocument) {
      final result = eachDocument.data()[DraftSubacConstants.ayahKey] ==
              ayahNumber &&
          eachDocument.data()[DraftSubacConstants.surahNameKey] == surahName;
      if (result) _isExisted = true;
    });
  } catch (exception) {
    print("eror ayaa dhacay ${exception}");
  }
  return _isExisted;
}
