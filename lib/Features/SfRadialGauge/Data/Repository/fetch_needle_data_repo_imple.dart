import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subac_app_update/Features/SfRadialGauge/Domain/Entity/Fetch_needle_data_entity.dart';
import 'package:subac_app_update/Features/SfRadialGauge/Domain/Repository/fetch_nnedle_data_repo.dart';

import '../Remote source/fetch_radial_needle_data.dart';

class FetchRadialNeedleDataRepoImple
    implements FetchRadialNeedleDataRepository {
  @override
  Future<FetchRadialNeedleDataEntity> fetchRadialNeedleDataRepo(
      {required WidgetRef ref}) {
    return fetchRadialNeedleInfo(ref: ref);
  }
}
