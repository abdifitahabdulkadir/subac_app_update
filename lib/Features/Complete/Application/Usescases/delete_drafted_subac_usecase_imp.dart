import 'package:flutter_riverpod/src/consumer.dart';

// custom improts
import '/Features/Complete/Domain/Usecase/delete_draftedSubacuse.dart';
import '../../Data/Respository/delete_drafted_subac_repo_imple.dart';

class DeleteDraftedSubacUsecaseImple implements DeleteDraftedSubacUsecase {
  DeleteDraftedSubacRepositoryImple _imple =
      DeleteDraftedSubacRepositoryImple();
  @override
  Future<bool> deleteDraftedUseCase({
    required WidgetRef ref,
    required String documentId,
  }) async {
    return await _imple.deleteDraftedRepository(
        ref: ref, documentId: documentId);
  }
}
