import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// custome imports
import '/Features/Dashboard/Presentation/State/combined_provider.dart';
import '/Features/Dashboard/Presentation/State/selected_page_index.dart';

class Dashboard extends ConsumerWidget {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  String getTitle({required WidgetRef ref}) {
    if (ref.read(selectedPageIndex.notifier).state == 0) {
      return "Home";
    } else if (ref.read(selectedPageIndex.notifier).state == 1)
      return "BookMark";
    else
      return "Profile";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(getTitle(ref: ref)),
          centerTitle: true,
        ),
        body: ref.watch(combinedScreensProvider)[ref.watch(selectedPageIndex)],
        bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            onTap: (currnetPageIndex) {
              if (currnetPageIndex >= ref.read(combinedScreensProvider).length)
                ;
              else
                ref
                    .watch(selectedPageIndex.notifier)
                    .update((state) => currnetPageIndex);
            },
            backgroundColor: Colors.transparent,
            color: Colors.grey.shade300,
            items: [
              Icon(
                Icons.home,
                size: 40,
                color: Theme.of(context).primaryColor
              ),
              Icon(
                Icons.bookmark,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
              Icon(
                Icons.person,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
            ]));
  }
}
