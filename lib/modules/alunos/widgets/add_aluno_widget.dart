import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/app/config/theme/app_text.dart';
import 'package:school/app/models/aluno_model.dart';
import 'package:school/app/utils/field_validation.dart';
import 'package:school/modules/alunos/controller/aluno_controller.dart';

import '../../../app/config/custom_snack.dart';

class AddAlunoWidget extends StatefulWidget {
  const AddAlunoWidget({super.key});

  @override
  State<AddAlunoWidget> createState() => _AddAlunoWidgetState();
}

class _AddAlunoWidgetState extends State<AddAlunoWidget> {
  final alunoController = Modular.get<AlunoController>();
  final snack = Modular.get<CustomSnack>();
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void dispose() {
    name.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> onSubmit() async {
    if (!formKey.currentState!.validate()) {
      snack.error(text: "Complete os campos corretamente");
      return;
    }

    final data = AlunoModel(name: name.text);

    setState(() => loading = true);
    await alunoController.addAluno(model: data);
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
            const Text("Adicionar aluno", style: AppText.title),
            const SizedBox(height: 16),
            TextFormField(
              controller: name,
              validator: FieldValidation.instance.validateName,
              decoration: const InputDecoration(
                labelText: "Nome",
                hintText: "Nome do aluno",
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
                  onPressed: onSubmit,
                  child: const Text("Adicionar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
