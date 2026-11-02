import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/controllers/auth_controller.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/dashboard/controllers/dashboard_controller.dart';
import 'features/dashboard/data/dashboard_repository.dart';
import 'features/language/controllers/language_controller.dart';
import 'features/language/data/language_repository.dart';
import 'features/settings/controllers/settings_controller.dart';
import 'features/settings/data/settings_repository.dart';



class CalleyApp extends StatelessWidget {
  const CalleyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController(AuthRepository())),
        ChangeNotifierProvider(create: (_) => LanguageController(LanguageRepository())),
        // ChangeNotifierProvider(
        //     create: (_) => DashboardController(DashboardRepository())..load()),
        ChangeNotifierProvider(
            create: (_) => DashboardController(DashboardRepository())),
        ChangeNotifierProvider(
            create: (_) => SettingsController(SettingsRepository())),
      ],
      child: MaterialApp(
        title: 'Calley',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: AppRoutes.language,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
