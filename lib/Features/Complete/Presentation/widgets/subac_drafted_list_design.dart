import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:intl/intl.dart';

// custom improts
import '/Features/Assembly/Presentation/State/ayan_state_provider.dart';
import '/Features/Assembly/Presentation/State/dropdown_provider.dart';
import '/Features/Assembly/Presentation/State/who_begins_provider.dart';
import '/Features/Complete/Data/DataState/complete_state_provider.dart';
import 'package:subac_app_update/config/routes/route_constant_names.dart';
import '../../Application/Usescases/delete_drafted_subac_usecase_imp.dart';
import '../../Application/Usescases/fetch_draftedsubac_usecase_imple.dart';
import '/config/themes/theme_manager_provider.dart';
import '/Features/Complete/Presentation/State/delete_loading_state.dart';
import '/config/themes/theming_app.dart';

class SubacListDesign extends ConsumerWidget {
  final FetchDraftedSubacUsecaseImple _draftedSubacUsecaseImple =
      FetchDraftedSubacUsecaseImple();
  final DeleteDraftedSubacUsecaseImple _deleteDraftedSubacUsecaseImple =
      DeleteDraftedSubacUsecaseImple();

  DateTime _convertTimeStampToDatetime({required Timestamp timestamp}) {
    DateTime date = timestamp.toDate();
    return date;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: _draftedSubacUsecaseImple.fetchDraftedUseCase(ref: ref),
        builder: (context, snapshoots) {
          if (snapshoots.connectionState == ConnectionState.waiting)
            return SizedBox(
              height: 60,
              child: Center(
                  child: LoadingIndicator(
                      colors: [Colors.green, Colors.black],
                      indicatorType: Indicator.circleStrokeSpin)),
            );

          return ListView.builder(
            itemBuilder: (_, index) {
              return Container(
                margin: EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: ref.watch(themeManagerProvider) == ThemeMode.light
                      ? lightTheme.colorScheme.primary
                      : darkTheme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: GestureDetector(
                  onTap: () {
                    ref.read(completeStateProvider.notifier).registerDocumentName(
                        context: context,
                        ref: ref,
                        documentId:
                            "${snapshoots.data![index].surahName}${snapshoots.data![index].ayahNumber}");
                    ref
                        .read(completeStateProvider.notifier)
                        .incrementCompleteState();
                    ref
                        .read(dropDownProvider.notifier)
                        .update((state) => snapshoots.data![index].surahName);
                    ref.read(nextAyahIndexProvider.notifier).adjustAyahState(
                        ayahNumber: snapshoots.data![index].ayahNumber);
                    ref.read(whoBeginsQuranReading.notifier).aiWillBeginState();
                    context.pushNamed(SubacRouteConstants.newAssemblyName);
                  },
                  child: ListTile(
                    leading: Image(
                      image: AssetImage("lib/core/images/kitab.png"),
                      height: 50,
                      width: 50,
                    ),
                    title: Text(
                      "${snapshoots.data![index].surahName} at ayah ${snapshoots.data![index].ayahNumber}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    subtitle: FittedBox(
                      child: Text(
                        "last drafted: ${DateFormat("MM/d/yyyy, H:m a").format(_convertTimeStampToDatetime(timestamp: snapshoots.data![index].dateTime)).toString()}",
                      ),
                    ),
                    trailing: ref.watch(deleteDraftSubacLoadingStateProvider)
                        ? CircularProgressIndicator()
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 40,
                            ),
                            onPressed: () async {
                              ref
                                  .watch(deleteDraftSubacLoadingStateProvider
                                      .notifier)
                                  .update((state) => true);
                              final _documentId =
                                  "${snapshoots.data![index].surahName}${snapshoots.data![index].ayahNumber}";
                              final _isDeleted =
                                  await _deleteDraftedSubacUsecaseImple
                                      .deleteDraftedUseCase(
                                ref: ref,
                                documentId: _documentId,
                              );
                              ref
                                  .watch(deleteDraftSubacLoadingStateProvider
                                      .notifier)
                                  .update((state) => false);
                              ScaffoldMessenger.of(context).clearSnackBars();
                              if (_isDeleted)
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  duration: Duration(milliseconds: 100),
                                  content:
                                      Text("${_documentId} has been deleted"),
                                ));
                            }),
                  ),
                ),
              );
            },
            itemCount: snapshoots.data!.length,
          );
        });
  }
}
