import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/app/config/theme/app_text.dart';
import 'package:school/app/models/aluno_model.dart';
import 'package:school/app/models/curso_aluno_model.dart';
import 'package:school/app/models/curso_model.dart';
import 'package:school/modules/cursos/controller/curso_controller.dart';

class AddAlunoCursoWidget extends StatefulWidget {
  final AlunoModel aluno;

  const AddAlunoCursoWidget({super.key, required this.aluno});

  @override
  State<AddAlunoCursoWidget> createState() => _AddAlunoCursoWidgetState();
}

class _AddAlunoCursoWidgetState extends State<AddAlunoCursoWidget> {
  final cursoController = Modular.get<CursoController>();
  CursoModel? cursoSelected;

  @override
  void initState() {
    cursoController.getCursos(update: false);
    super.initState();
  }

  Future<void> addToCurso() async {
    if (cursoSelected == null) return;

    final data = CursoAlunoModel(
      codigo: Random().nextInt(100), //Apenas para teste
      codigoAluno: widget.aluno.codigo!,
      codigoCurso: cursoSelected!.codigo!,
    );
    bool res = await cursoController.addAlunoCurso(model: data);

    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, func) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Adicione ${widget.aluno.name!} á algum curso",
                style: AppText.title,
              ),
              const SizedBox(height: 16),
              Observer(
                builder: (context) {
                  if (cursoController.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  if (cursoController.cursos.isEmpty) {
                    return const Center(
                      child: Text('Nenhum curso encontrado.'),
                    );
                  }
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<CursoModel>(
                          hint: const Text("Selecione um curso"),
                          value: cursoSelected,
                          items: cursoController.cursos.map((e) {
                            return DropdownMenuItem<CursoModel>(
                              value: e,
                              child: Text(e.descricao ?? "n/a"),
                            );
                          }).toList(),
                          onChanged: (value) {
                            func(() => cursoSelected = value);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              if (cursoSelected != null)
                ElevatedButton(
                  onPressed: addToCurso,
                  child: const Text("Adicionar"),
                )
            ],
          ),
        );
      },
    );
  }
}
