import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subac_app_update/config/state/firebase_constants.dart';

// imports
import '../constants/constants.dart';

Future<bool> isThisUserHasDocumentAlready(
    {required String documentId, required WidgetRef ref}) async {
  bool _isExisted = false;
  try {
    final _fetchDocument = await ref
        .read(firebaseFirebaseInstanceProvider)
        .collection(DraftSubacConstants.collectionName)
        .doc(documentId)
        .get();
    if (_fetchDocument.id.isNotEmpty) _isExisted = true;
  } catch (exception) {
    print("eror ayaa dhacay ${exception}");
  }
  return _isExisted;
}
