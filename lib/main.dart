import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

// my imports
import '/Features/Dashboard/Presentation/Screens/dashboard.dart';
import 'config/themes/theme_manager_provider.dart';
import 'config/themes/theming_app.dart';
import '/firebase_options.dart';
import 'Features/Authentication/Presentation/screens/register_login.dart';

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
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshotController) {
            if (snapshotController.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              );
            if (snapshotController.hasData) {
              return Dashboard();
            }
            return RegisterLogin();
          }),
    );
  }
}
