import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// custome imports
import '/Features/Dashboard/Presentation/State/combined_provider.dart';
import '/Features/Dashboard/Presentation/State/selected_page_index.dart';

class Dashboard extends ConsumerWidget {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Profile"),
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
                color: Color.fromARGB(255, 49, 202, 169),
              ),
              Icon(
                Icons.bookmark,
                size: 40,
                color: Color.fromARGB(255, 49, 202, 169),
              ),
              Icon(
                Icons.person,
                size: 40,
                color: Color.fromARGB(255, 49, 202, 169),
              ),
            ]));
  }
}
