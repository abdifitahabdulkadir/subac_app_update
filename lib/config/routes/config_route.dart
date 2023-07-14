import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// my custom imports
import '../../Features/Assembly/Presentation/Screens/new_assembly_screen.dart';
import '../../Features/Complete/Presentation/Screens/complete_task.dart';
import '../../Features/Dashboard/Presentation/Screens/dashboard.dart';
import '../../Features/Userprofile/Presentation/screens/edit_profile_informatioin.dart';
import '../../Features/Userprofile/Presentation/screens/setting.dart';
import '../state/app_state_provider.dart';
import '/Features/Authentication/Presentation/screens/register_login.dart';
import 'route_constant_names.dart';

class SubacAppRoutes {
  static GoRouter returnRouters({required WidgetRef ref}) {
    return GoRouter(routes: [
      GoRoute(
          name: SubacRouteConstants.dashboardName,
          path: SubacPathConstants.dashboardPath,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialPage(child: Dashboard());
          },
          redirect: (context, state) {
            return ref.watch(appStateProvider).when(data: (currentState) {
              if (currentState == null)
                return SubacPathConstants.loginRegisterPath;
              return null;
            }, error: (message, _) {
              return message.toString();
            }, loading: () {
              return "loading nhhh";
            });
          },
          routes: [
            GoRoute(
              name: SubacRouteConstants.newAssemblyName,
              path: SubacPathConstants.newAssemblyPath,
              pageBuilder: (context, state) {
                return MaterialPage(child: NewAssemblyScreen());
              },
            ),
            GoRoute(
              name: SubacRouteConstants.completeTaskName,
              path: SubacPathConstants.completeTaskPath,
              pageBuilder: (context, state) {
                return MaterialPage(child: CompeleteTask());
              },
            ),
            GoRoute(
                name: SubacRouteConstants.editUserInformationName,
                path: SubacPathConstants.editUserInformationPath,
                pageBuilder: (context, state) {
                  return MaterialPage(child: EditProfileInformation());
                }),
            GoRoute(
              name: SubacRouteConstants.settingName,
              path: SubacPathConstants.settingPath,
              pageBuilder: (context, state) {
                return MaterialPage(child: Setting());
              },
            )
          ]),
      GoRoute(
        name: SubacRouteConstants.loginRegisterName,
        path: SubacPathConstants.loginRegisterPath,
        pageBuilder: (context, state) {
          return MaterialPage(child: RegisterLogin());
        },
      )
    ]);
  }
}
