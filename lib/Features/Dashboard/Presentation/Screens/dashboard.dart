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
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            getTitle(ref: ref),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 30,
                ),
          ),
          centerTitle: true,
        ),
        body: ref.watch(currentSelectedWidget),
        bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: ref.watch(selectedPageIndex),
            onTap: (currnetPageIndex) {
              if (currnetPageIndex == ref.read(selectedPageIndex))
                return;
              else
                ref
                    .watch(selectedPageIndex.notifier)
                    .update((state) => currnetPageIndex);
            },
            backgroundColor: Colors.transparent,
            color: Theme.of(context).colorScheme.primary,
            buttonBackgroundColor: Theme.of(context).colorScheme.primary,
            items: [
              Icon(
                Icons.home,
                size: 40,
                color: Colors.white,
              ),
              Icon(
                Icons.bookmark,
                size: 40,
                color: Colors.white,
              ),
              Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ]));
  }
}
