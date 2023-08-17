import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/state/firebase_constants.dart';
import '../constants/constants.dart';

Future<bool> updateCurrentDocument(
    {required String documentId,
    required String surahName,
    required int ayahNumber,
    required String userid,
    required DateTime datetime,
    required int surahAyahLength,
    required WidgetRef ref}) async {
  bool _isExisted = false;
  try {
    await ref
        .read(firebaseFirebaseInstanceProvider)
        .collection(DraftSubacConstants.collectionName)
        .doc(ref.read(firebaseAuthInstanceProvider).currentUser!.uid)
        .collection(DraftSubacConstants.subCollectionName)
        .doc(documentId)
        .update({
      DraftSubacConstants.ayahKey: ayahNumber,
      DraftSubacConstants.surahNameKey: surahName,
      DraftSubacConstants.datetimeKey: datetime,
      DraftSubacConstants.useridKey: userid,
      DraftSubacConstants.surahAyahLengthKey: surahAyahLength,
    });
  } catch (exception) {
   
  }

  return _isExisted;
}
