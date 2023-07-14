import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/config/routes/route_constant_names.dart';
import '/config/themes/theme_manager_provider.dart';

class Assembly extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () =>
          GoRouter.of(context).go("/${SubacPathConstants.newAssemblyPath}"),
      child: SizedBox(
        width: 350,
        child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Image(image: AssetImage("lib/core/images/kitab.png"), height: 50),
              SizedBox(height: 10),
              Text(
                "Assembly",
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
