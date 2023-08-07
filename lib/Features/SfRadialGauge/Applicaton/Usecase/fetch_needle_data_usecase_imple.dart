import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subac_app_update/Features/SfRadialGauge/Domain/Usecase/fetch_needle_data_usercase.dart';
import 'package:subac_app_update/Features/SfRadialGauge/Presentation/state/radial_provider.dart';
import '../../Data/Repository/fetch_needle_data_repo_imple.dart';

class FetchNeedleDataUsecaseImple implements FetchRadialNeedleDataUsecase {
  FetchRadialNeedleDataRepoImple _dataRepoImple =
      FetchRadialNeedleDataRepoImple();
  @override
  Future<void> fetchRadialNeedleData({required WidgetRef ref}) async {
    await _dataRepoImple.fetchRadialNeedleDataRepo(ref: ref).then((value) {
      ref
          .read(radialValueProvider.notifier)
          .update((state) => value.incompleteDraftValue);
    });
  }
}
