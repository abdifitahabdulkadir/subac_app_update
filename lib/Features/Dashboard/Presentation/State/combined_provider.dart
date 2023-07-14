import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subac_app_update/Features/Dashboard/Presentation/State/selected_page_index.dart';
import 'package:subac_app_update/Features/Userprofile/Presentation/widgets/user_profile.dart';

//my imports
import '/Features/Dashboard/Presentation/widgets/home.dart';

final currentSelectedWidget = StateProvider<Widget>((ref) {
  final _selectedPageIndex = ref.watch(selectedPageIndex);
  if (_selectedPageIndex == 0)
    return Home();
  else if (_selectedPageIndex == 1)
    return Home();
  else
    return UserProfile();
});
