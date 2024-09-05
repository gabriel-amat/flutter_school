import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/app/shared/widgets/custom_appbar.dart';
import 'package:school/app/shared/widgets/notification_icon_widget.dart';
import 'package:school/app/shared/widgets/user_icon_widget.dart';
import 'package:school/modules/alunos/controller/aluno_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:school/modules/alunos/widgets/add_aluno_widget.dart';
import 'package:school/modules/alunos/widgets/aluno_list_widget.dart';

import '../../app/config/theme/app_text.dart';
import '../../app/shared/widgets/mobile_drawer.dart';
import '../../app/utils/responsive_widget.dart';

class AlunoPage extends StatefulWidget {
  const AlunoPage({super.key});

  @override
  State<AlunoPage> createState() => _AlunoPageState();
}

class _AlunoPageState extends State<AlunoPage> {
  final alunoController = Modular.get<AlunoController>();
  final searchController = TextEditingController();

  @override
  void initState() {
    alunoController.getAlunos(update: false);
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
              child: CustomAppbar(title: "Alunos"),
            ),
      floatingActionButton: ResponsiveWidget.isLargeScreen(context)
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const SimpleDialog(
                    children: [
                      AddAlunoWidget(),
                    ],
                  ),
                );
              },
              label: const Text("Adicionar"),
              icon: const Icon(Icons.add),
            ),
      body: RefreshIndicator(
        onRefresh: () async {
          alunoController.getAlunos(update: true);
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
                                "Alunos",
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
                              alunoController.getAlunos(update: true);
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
                                  children: [
                                    AddAlunoWidget(),
                                  ],
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
                    hintText: "Pesquise pelo nome",
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
                    if (alunoController.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }

                    if (alunoController.alunos.isEmpty) {
                      return const Center(
                        child: Text('Nenhum aluno encontrado.'),
                      );
                    }
                    return AlunoListWidget(
                      list: alunoController.alunos,
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
