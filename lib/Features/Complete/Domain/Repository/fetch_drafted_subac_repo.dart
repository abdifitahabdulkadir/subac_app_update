import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Entity/fetch_drafted_subac.dart';

abstract class FetchDraftedSubacRepository {
  Future<List<FetchDraftedSubacEntity>> fetchDraftedSubacReposity(
      {required WidgetRef ref});
}
