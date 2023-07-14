import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subac_app_update/Features/Complete/Presentation/Screens/complete_task.dart';
import 'package:subac_app_update/config/routes/route_constant_names.dart';
import 'package:subac_app_update/config/themes/theme_manager_provider.dart';

class CompleteAssembly extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () =>
          GoRouter.of(context).go("/${SubacPathConstants.completeTaskPath}"),
      child: SizedBox(
        width: 350,
        child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Image(image: AssetImage("lib/core/images/comp.png"), height: 50),
              SizedBox(height: 10),
              Text(
                "Complete",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: ref.watch(themeManagerProvider) == ThemeMode.light
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                    ),
              ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
