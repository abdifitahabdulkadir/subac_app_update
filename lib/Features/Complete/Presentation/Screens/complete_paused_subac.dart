import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// custom widgets
import '../widgets/subac_drafted_list_design.dart';
import '/Features/Complete/Application/Usescases/fetch_draftedsubac_usecase_imple.dart';
import '/Features/Complete/Presentation/widgets/complete_task.dart';

class CompletePausedSubac extends ConsumerStatefulWidget {
  @override
  ConsumerState<CompletePausedSubac> createState() =>
      _CompletePausedSubacState();
}

class _CompletePausedSubacState extends ConsumerState<CompletePausedSubac> {
  final FetchDraftedSubacUsecaseImple _draftedSubacUsecaseImple =
      FetchDraftedSubacUsecaseImple();
  late bool isLengthOfDataEmpty = false;
  _init() async {
    await _draftedSubacUsecaseImple.fetchDraftedUseCase(ref: ref).then(
      (value) {
        if (value.isEmpty)
          setState(() {
            isLengthOfDataEmpty = true;
          });
        else
          setState(() {
            isLengthOfDataEmpty = false;
          });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: Text(
            "Drafted Subac Lists",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          elevation: 0,
          leading: BackButton(color: Colors.white),
        ),
        body: isLengthOfDataEmpty ? CompeleteTask() : SubacListDesign());
  }
}
