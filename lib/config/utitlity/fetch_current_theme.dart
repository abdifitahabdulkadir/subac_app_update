import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../respository/dynamic_theme_state.dart';

ThemeManagementRepository _managementRepository = ThemeManagementRepository();
void fetchCurrentTheme({required WidgetRef ref}) async {
  await _managementRepository.storeAppTheme(ref: ref);
}
