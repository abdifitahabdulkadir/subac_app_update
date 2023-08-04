import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/Features/Complete/Domain/Entity/fetch_drafted_subac.dart';

abstract class FetchDraftedSubacUsecase {
  Future<List<FetchDraftedSubacEntity>> fetchDraftedUseCase(
      {required WidgetRef ref});
}
