import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DeleteDraftedSubacUsecase {
  Future<bool> deleteDraftedUseCase({
    required WidgetRef ref,
    required String documentId,
  });
}
