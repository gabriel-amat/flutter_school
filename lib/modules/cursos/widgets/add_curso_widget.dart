import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/app/config/custom_snack.dart';
import 'package:school/app/config/theme/app_text.dart';
import 'package:school/app/models/curso_model.dart';
import 'package:school/app/utils/field_validation.dart';
import 'package:school/modules/cursos/controller/curso_controller.dart';

class AddCursoWidget extends StatefulWidget {
  const AddCursoWidget({super.key});

  @override
  State<AddCursoWidget> createState() => _AddCursoWidgetState();
}

class _AddCursoWidgetState extends State<AddCursoWidget> {
  final alunoController = Modular.get<CursoController>();
  final snack = Modular.get<CustomSnack>();
  final description = TextEditingController();
  final ementa = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void dispose() {
    description.dispose();
    ementa.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    if (!formKey.currentState!.validate()) {
      snack.error(text: "Preencha os campos corretamente para continuar");
      return;
    }
    final data = CursoModel(
      ementa: ementa.text,
      descricao: description.text,
    );
    setState(() => loading = true);
    await alunoController.addCurso(model: data);
    setState(() => loading = false);

    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Adicionar Curso", style: AppText.title),
            const SizedBox(height: 16),
            TextFormField(
              controller: description,
              validator: FieldValidation.instance.commonField,
              decoration: const InputDecoration(
                labelText: "Descrição",
                hintText: "Descrição do curso",
              ),
            ),
            const SizedBox(height: 22),
            TextFormField(
              controller: ementa,
              validator: FieldValidation.instance.commonField,
              decoration: const InputDecoration(
                labelText: "Ementa",
                hintText: "Ementa do curso",
              ),
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: const Text("Cancelar"),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: loading ? null : onSubmit,
                  child: loading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : const Text("Adicionar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
