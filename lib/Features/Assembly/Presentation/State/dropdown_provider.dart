import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subac_app_update/Features/Assembly/Presentation/State/surah_names_provider.dart';

final dropDownProvider = StateProvider.autoDispose<String>(
    (ref) => ref.watch(surahNamesProvider)[0]);
