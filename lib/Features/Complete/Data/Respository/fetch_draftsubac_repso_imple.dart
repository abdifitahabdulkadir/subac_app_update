import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Domain/Entity/fetch_drafted_subac.dart';
import '../Remote/fetch_drafted_subac.dart';
import '/Features/Complete/Domain/Repository/fetch_drafted_subac_repo.dart';

class FetchDraftedSubacRepoImplemented implements FetchDraftedSubacRepository {
  @override
  Future<List<FetchDraftedSubacEntity>> fetchDraftedSubacReposity(
      {required WidgetRef ref}) {
    return fetchDraftedSubacInFirebase(ref: ref);
  }
}
