import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

// my imports
import 'package:subac_app_update/config/routes/config_route.dart';
import 'config/themes/theme_manager_provider.dart';
import 'config/themes/theming_app.dart';
import 'package:subac_app_update/config/state/firebase_constants.dart';
import '/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: SubacAppUpdate()));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class SubacAppUpdate extends ConsumerStatefulWidget {
  const SubacAppUpdate({super.key});
  @override
  ConsumerState<SubacAppUpdate> createState() => _SubacAppUpdateState();
}


class _SubacAppUpdateState extends ConsumerState<SubacAppUpdate> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData(ref: ref);
  }

  void getData({required WidgetRef ref}) async {
    if (ref.read(firebaseAuthInstanceProvider).currentUser == null) {
      ref
          .read(themeManagerProvider.notifier)
          .update((state) => ThemeMode.light);
      return;
    }
    ref
        .watch(firebaseFirebaseInstanceProvider)
        .collection("appTheme")
        .doc(ref.read(firebaseAuthInstanceProvider).currentUser!.uid)
        .get()
        .then((value) {
      if (value.data()!.isEmpty)
        ref
            .read(themeManagerProvider.notifier)
            .update((state) => ThemeMode.light);
      else
        value.data()?["themeType"] == "dark"
            ? ref
                .read(themeManagerProvider.notifier)
                .update((state) => ThemeMode.dark)
            : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ref.watch(themeManagerProvider),
      routerConfig: SubacAppRoutes.returnRouters(ref: ref),
    );
  }
}
