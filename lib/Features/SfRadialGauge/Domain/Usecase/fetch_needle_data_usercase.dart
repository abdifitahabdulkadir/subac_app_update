import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/Features/SfRadialGauge/Domain/Entity/Fetch_needle_data_entity.dart';

abstract class FetchRadialNeedleDataUsecase {
  Future<void> fetchRadialNeedleData(
      {required WidgetRef ref});
}
