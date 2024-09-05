import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/app/config/custom_snack.dart';
import 'package:school/app/config/theme/app_text.dart';
import 'package:school/app/models/aluno_model.dart';
import 'package:school/app/utils/field_validation.dart';
import 'package:school/modules/alunos/controller/aluno_controller.dart';
import 'package:school/modules/alunos/widgets/add_aluno_curso_widget.dart';
import 'package:school/modules/cursos/widgets/curso_list_widget.dart';

class AlunoDetailPage extends StatefulWidget {
  final AlunoModel model;

  const AlunoDetailPage({super.key, required this.model});

  @override
  State<AlunoDetailPage> createState() => _AlunoDetailPageState();
}

class _AlunoDetailPageState extends State<AlunoDetailPage> {
  final alunoController = Modular.get<AlunoController>();
  final snack = Modular.get<CustomSnack>();
  final name = TextEditingController();
  final searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    name.text = widget.model.name ?? "";
    alunoController.getAlunoCursos(update: true, userId: widget.model.codigo!);
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    searchController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  void onSubmit() async {
    if (!formKey.currentState!.validate()) {
      snack.error(text: "Complete os campos corretamente");
      return;
    }
    setState(() => isLoading = true);
    await alunoController.updateAluno(
      model: widget.model..name = name.text,
    );
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(widget.model.name ?? "Aluno"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Dados pessoais", style: AppText.title),
                const SizedBox(height: 16),
                TextFormField(
                  controller: name,
                  validator: FieldValidation.instance.validateName,
                  decoration: const InputDecoration(
                    labelText: "Nome",
                    prefixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: isLoading ? null : onSubmit,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : const Text("Atualizar"),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(),
                ),
                Row(
                  children: [
                    const Text("Cursos matriculados", style: AppText.title),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () async {
                        bool res = await showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                            children: [
                              AddAlunoCursoWidget(aluno: widget.model),
                            ],
                          ),
                        );
                        if (res) {
                          alunoController.getAlunoCursos(
                            update: true,
                            userId: widget.model.codigo!,
                          );
                        }
                      },
                      child: const Text("Nova matricula"),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                //Cursos
                Observer(
                  builder: (_) {
                    if (alunoController.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }

                    if (alunoController.alunos.isEmpty) {
                      return const Center(
                        child: Text('Nenhum curso encontrado.'),
                      );
                    }
                    return CursoListWidget(
                      list: alunoController.alunoCursos,
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
