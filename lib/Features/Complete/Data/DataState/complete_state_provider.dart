import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subac_app_update/Features/Assembly/Presentation/State/who_begins_provider.dart';

// custom improts
import '../../Application/Usescases/delete_drafted_subac_usecase_imp.dart';
import '/Features/Assembly/Presentation/State/ayan_state_provider.dart';
import '/Features/Assembly/Presentation/State/surah_ayan_length_provider.dart';
import '/config/routes/route_constant_names.dart';

class CompleteStateNotifier extends StateNotifier<int> {
  CompleteStateNotifier() : super(0);
  String _saveDocumentId = "";
  late WidgetRef _getWidgetRefernece;
  late BuildContext _saveContext;
  final DeleteDraftedSubacUsecaseImple _usecaseImple =
      DeleteDraftedSubacUsecaseImple();
  // increment means ai is reading quran
  void incrementCompleteState() {
    state = 1;
  }

  // making state two to hide some widgets in the there
  void makeStateTwoForFurtherReading() {
    state = 2;
  }

  // registerDocumentId
  void registerDocumentName(
      {required String documentId,
      required BuildContext context,
      required WidgetRef ref}) {
    _saveDocumentId = documentId;
    _getWidgetRefernece = ref;
    _saveContext = context;
  }

// deleting the drafted suabc after user completes only.
  Future<void> deleteDocument() async {
    if (state == 0 &&
        _saveDocumentId.isNotEmpty &&
        _getWidgetRefernece.read(nextAyahIndexProvider) ==
            _getWidgetRefernece.read(surahAyahLengthProvider)) {
      await _usecaseImple.deleteDraftedUseCase(
        ref: _getWidgetRefernece,
        documentId: _saveDocumentId,
      );
      Future.delayed(Duration(seconds: 6), () {
        _getWidgetRefernece
            .read(whoBeginsQuranReading.notifier)
            .resetWhoBegins();
        _getWidgetRefernece.read(nextAyahIndexProvider.notifier).resetAyah();
        GoRouter.of(_saveContext)
            .goNamed(SubacRouteConstants.completePausedSubacName);
      });
    }
  }

  // reset the starte to 0
  void resetCompleteState() {
    state = 0;
    deleteDocument();
  }
}

final completeStateProvider = StateNotifierProvider<CompleteStateNotifier, int>(
    (ref) => CompleteStateNotifier());
