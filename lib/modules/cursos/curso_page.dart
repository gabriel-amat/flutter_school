import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/app/config/theme/app_text.dart';
import 'package:school/modules/cursos/controller/curso_controller.dart';
import 'package:school/modules/cursos/widgets/add_curso_widget.dart';
import 'package:school/modules/cursos/widgets/curso_list_widget.dart';

import '../../app/shared/widgets/custom_appbar.dart';
import '../../app/shared/widgets/mobile_drawer.dart';
import '../../app/shared/widgets/notification_icon_widget.dart';
import '../../app/shared/widgets/user_icon_widget.dart';
import '../../app/utils/responsive_widget.dart';

class CursoPage extends StatefulWidget {
  const CursoPage({super.key});

  @override
  State<CursoPage> createState() => _CursoPageState();
}

class _CursoPageState extends State<CursoPage> {
  final controller = Modular.get<CursoController>();
  final searchController = TextEditingController();

  @override
  void initState() {
    controller.getCursos(update: false);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:
          ResponsiveWidget.isLargeScreen(context) ? null : const MobileDrawer(),
      appBar: ResponsiveWidget.isLargeScreen(context)
          ? null
          : const PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: CustomAppbar(title: "Cursos"),
            ),
      floatingActionButton: ResponsiveWidget.isLargeScreen(context)
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const SimpleDialog(
                    children: [AddCursoWidget()],
                  ),
                );
              },
              label: const Text("Adicionar"),
              icon: const Icon(Icons.add),
            ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getCursos(update: true);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Title
                ResponsiveWidget.isLargeScreen(context)
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cursos",
                                style: AppText.bigTitle
                                    .copyWith(color: Colors.black),
                              ),
                              const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  NotificationIconWidget(),
                                  SizedBox(width: 16),
                                  UserIconWidget(),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(height: 22),
                        ],
                      )
                    : const SizedBox.shrink(),

                //Buttons
                ResponsiveWidget.isLargeScreen(context)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Refresh button
                          IconButton(
                            onPressed: () {
                              controller.getCursos(update: true);
                            },
                            icon: const Icon(Icons.refresh),
                          ),
                          const SizedBox(width: 16),
                          //Add button
                          ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => const SimpleDialog(
                                  children: [AddCursoWidget()],
                                ),
                              );
                            },
                            label: const Text("Adicionar"),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 22),
                //Search field
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Pesquise pelo nome do curso",
                    labelText: "Pesquisar",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchController.clear();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                //List
                Observer(
                  builder: (_) {
                    if (controller.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }

                    if (controller.cursos.isEmpty) {
                      return const Center(
                        child: Text('Nenhum curso encontrado.'),
                      );
                    }
                    return CursoListWidget(
                      list: controller.cursos,
                      searchController: searchController,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
