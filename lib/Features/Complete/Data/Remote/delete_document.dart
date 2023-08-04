import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/state/firebase_constants.dart';
import '../constants/constants.dart';

Future<bool> deleteDocument(
    {required String documentId, required WidgetRef ref}) async {
  bool _isExisted = false;
  try {
    await ref
        .read(firebaseFirebaseInstanceProvider)
        .collection(DraftSubacConstants.collectionName)
        .doc(ref.read(firebaseAuthInstanceProvider).currentUser!.uid)
        .collection(DraftSubacConstants.subCollectionName)
        .doc(documentId)
        .delete()
        .then((value) => _isExisted = true);
  } catch (exception) {
    print("eror ayaa dhacay ${exception}");
  }

  return _isExisted;
}
