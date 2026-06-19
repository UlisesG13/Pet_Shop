import 'package:flutter/material.dart';

import 'core/constants/app_constants.dart';
import 'core/dependency_injection/injection_container.dart';
import 'core/routes/app_routes.dart';
import 'shared/theme/app_theme.dart';

class PetShopApp extends StatelessWidget {
  final InjectionContainer di;

  const PetShopApp({super.key, required this.di});

  @override
  Widget build(BuildContext context) {
    return di.provide(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        theme: AppTheme.light(),
        initialRoute: AppRoutes.initial,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
