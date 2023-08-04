import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subac_app_update/Features/SfRadialGauge/Domain/Entity/Fetch_needle_data_entity.dart';
import 'package:subac_app_update/Features/SfRadialGauge/Domain/Usecase/fetch_needle_data_usercase.dart';

import '../../Data/Repository/fetch_needle_data_repo_imple.dart';

class FetchNeedleDataUsecaseImple implements FetchRadialNeedleDataUsecase {
  FetchRadialNeedleDataRepoImple _dataRepoImple =
      FetchRadialNeedleDataRepoImple();
  @override
  Future<FetchRadialNeedleDataEntity> fetchRadialNeedleData(
      {required WidgetRef ref}) {
    return _dataRepoImple.fetchRadialNeedleDataRepo(ref: ref);
  }
}
