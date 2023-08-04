import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subac_app_update/Features/Complete/Data/constants/constants.dart';

import '../../../../config/state/firebase_constants.dart';
import '../../Domain/Entity/fetch_drafted_subac.dart';

Future<List<FetchDraftedSubacEntity>> fetchDraftedSubacInFirebase({
  required WidgetRef ref,
}) async {
  List<FetchDraftedSubacEntity> _getSurahDraftedInformation = [];

  try {
    await ref
        .read(firebaseFirebaseInstanceProvider)
        .collection("drafted_subac")
        .doc("${ref.read(firebaseAuthInstanceProvider).currentUser!.uid}")
        .collection("your_subac_drafts")
        .orderBy(DraftSubacConstants.datetimeKey)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> draftKeyValuePair) {
      draftKeyValuePair.docs.forEach(
        (element) => _getSurahDraftedInformation.add(FetchDraftedSubacEntity(
            ayahNumber: element.data()[DraftSubacConstants.ayahKey],
            dateTime: element.data()[DraftSubacConstants.datetimeKey],
            surahName: element.data()[DraftSubacConstants.surahNameKey],
            surahAyahLength:
                element.data()[DraftSubacConstants.surahAyahLengthKey])),
      );
    });
  } catch (exception) {
    print(exception.toString());
  }
  return _getSurahDraftedInformation;
}
