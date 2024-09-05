import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/app/utils/responsive_widget.dart';
import 'package:school/modules/home/widgets/custom_drawer.dart';

import '../../app/config/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  void initState() {
    if (kIsWeb) {
      // Configura a rota inicial
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Modular.to.navigate(AppRoutes.alunoPage);
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int page) {
    Modular.to.navigate(switch (page) {
      0 => AppRoutes.alunoPage,
      1 => AppRoutes.cursoPage,
      _ => AppRoutes.alunoPage,
    });
    debugPrint("OnPageChanged $page");
    setState(() => currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ResponsiveWidget.isLargeScreen(context)
          ? null
          : BottomNavigationBar(
              currentIndex: currentPage,
              onTap: onPageChanged,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.group),
                  label: 'Alunos',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school_rounded),
                  label: 'Cursos',
                ),
              ],
            ),
      body: Row(
        children: [
          ResponsiveWidget.isLargeScreen(context)
              ? const CustomDrawer()
              : const SizedBox.shrink(),
          ResponsiveWidget.isLargeScreen(context)
              ? const Expanded(
                  child: RouterOutlet(),
                )
              : Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: const [
                      RouterOutlet(),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
