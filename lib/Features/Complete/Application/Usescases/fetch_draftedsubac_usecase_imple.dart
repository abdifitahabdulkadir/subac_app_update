import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/Features/Complete/Domain/Usecase/fetch_drafted_subac_usecase.dart';

import '../../Data/Respository/fetch_draftsubac_repso_imple.dart';
import '../../Domain/Entity/fetch_drafted_subac.dart';

class FetchDraftedSubacUsecaseImple implements FetchDraftedSubacUsecase {
  FetchDraftedSubacRepoImplemented _implemented =
      FetchDraftedSubacRepoImplemented();
  @override
  Future<List<FetchDraftedSubacEntity>> fetchDraftedUseCase(
      {required WidgetRef ref}) {
    return _implemented.fetchDraftedSubacReposity(ref: ref);
  }
}
