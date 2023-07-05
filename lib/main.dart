import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import '/Features/Userprofile/Presentation/screens/setting.dart';


// my imports
import '/Features/Dashboard/Presentation/Screens/dashboard.dart';
import 'config/themes/theme_manager_provider.dart';
import 'config/themes/theming_app.dart';
import '/Features/Userprofile/Presentation/screens/edit_profile_informatioin.dart';
import '/Features/Authentication/Presentation/screens/register_login.dart';
import 'package:subac_app_update/core/state/firebase_constants.dart';
import '/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: SubacAppUpdate()));
}

class SubacAppUpdate extends ConsumerWidget {
  const SubacAppUpdate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ref.watch(themeManagerProvider),
      home: StreamBuilder(
          stream: ref.watch(firebaseAuthInstanceProvider).authStateChanges(),
          builder: (BuildContext context, snapshoots) {
            if (snapshoots.hasData) return Dashboard();
            return RegisterLogin();
          }),
      routes: {
        EditProfileInformation.routeName: (context) => EditProfileInformation(),
        Setting.routeName: (context) => Setting()
      },
    );
  }
}
