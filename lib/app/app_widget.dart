import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/app/config/app_routes.dart';
import 'package:school/app/config/custom_snack.dart';
import 'package:school/app/config/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(AppRoutes.alunoPage);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "School",
      routerConfig: Modular.routerConfig,
      theme: AppTheme.theme,
      scaffoldMessengerKey: Modular.get<CustomSnack>().snackbarKey,
    );
  }
}
