import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Entity/Fetch_needle_data_entity.dart';

abstract class FetchRadialNeedleDataRepository {
  Future<FetchRadialNeedleDataEntity> fetchRadialNeedleDataRepo(
      {required WidgetRef ref});
}
