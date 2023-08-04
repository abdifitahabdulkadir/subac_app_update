import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DeleteDraftedSubacRepository {
  Future<bool> deleteDraftedRepository({
    required WidgetRef ref,
    required String documentId,
  });
}
