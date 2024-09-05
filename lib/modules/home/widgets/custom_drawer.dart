import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/app/config/theme/app_colors.dart';
import 'package:school/app/config/theme/app_text.dart';

import '../../../app/config/app_routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.2,
      height: double.maxFinite,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondary, AppColors.primary],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Flutter School", style: AppText.bigTitle),
            Column(
              children: [
                InkWell(
                  key: const ValueKey('openAlunoPage'),
                  onTap: () {
                    Modular.to.navigate(AppRoutes.alunoPage);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.group, color: Colors.white),
                      SizedBox(width: 12),
                      Text("Alunos", style: AppText.menuItem),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                InkWell(
                  key: const ValueKey('openCursoPage'),
                  onTap: () {
                    Modular.to.navigate(AppRoutes.cursoPage);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school_rounded, color: Colors.white),
                      SizedBox(width: 12),
                      Text("Cursos", style: AppText.menuItem),
                    ],
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.exit_to_app_rounded, color: Colors.white),
                SizedBox(width: 5),
                Text("Sair", style: AppText.menuItem)
              ],
            )
          ],
        ),
      ),
    );
  }
}
