import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//my imports
import '/Features/Userprofile/Presentation/state/firebase_constants.dart';
import '/Features/Dashboard/Presentation/widgets/home.dart';

final combinedScreensProvider = StateProvider<List<Widget>>(
  (ref) {
    List<Widget> _pages = [];
    final _userProfileWidget = ref.watch(userProfileProvider);
    _pages.add(Home());
    _pages.add(Home());
    _pages.add(_userProfileWidget);
    return _pages;
  },
);
