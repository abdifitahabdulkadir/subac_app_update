import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subac_app_update/Features/SfRadialGauge/Domain/Entity/Fetch_needle_data_entity.dart';

// my imports
import 'package:subac_app_update/config/state/firebase_constants.dart';

Future<FetchRadialNeedleDataEntity> fetchRadialNeedleInfo(
    {required WidgetRef ref}) async {
  final String collectionName = "drafted_subac";
  final String subCollectionName = "your_subac_drafts";

  double _calculateSumPercentage = 0;
  await ref
      .read(firebaseFirebaseInstanceProvider)
      .collection(collectionName)
      .doc(ref.read(firebaseAuthInstanceProvider).currentUser!.uid)
      .collection(subCollectionName)
      .get()
      .then((userDocuments) {
    userDocuments.docs.forEach((element) {
      _calculateSumPercentage += (element.data()["surah_ayah_length"] /
          (element.data()["ayah_number"] == 0
              ? 1
              : element.data()["ayah_number"]));
    });
  });

  return FetchRadialNeedleDataEntity(
      incompleteDraftValue: _calculateSumPercentage);
}
