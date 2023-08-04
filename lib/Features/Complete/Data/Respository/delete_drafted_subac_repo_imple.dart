import 'package:flutter_riverpod/src/consumer.dart';
import '../Remote/delete_document.dart';
import '/Features/Complete/Domain/Repository/delete_drafted_subac_repo.dart';

class DeleteDraftedSubacRepositoryImple
    implements DeleteDraftedSubacRepository {
  @override
  Future<bool> deleteDraftedRepository(
      {required WidgetRef ref, required String documentId}) async {
    return await deleteDocument(documentId: documentId, ref: ref);
  }
}
