import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/app/config/custom_snack.dart';
import 'package:school/app/config/theme/app_text.dart';
import 'package:school/app/models/curso_model.dart';
import 'package:school/app/utils/field_validation.dart';
import 'package:school/modules/cursos/controller/curso_controller.dart';
import 'package:school/modules/cursos/widgets/turma_status.dart';

class CursoDetailPage extends StatefulWidget {
  final CursoModel model;

  const CursoDetailPage({super.key, required this.model});

  @override
  State<CursoDetailPage> createState() => _CursoDetailPageState();
}

class _CursoDetailPageState extends State<CursoDetailPage> {
  final controller = Modular.get<CursoController>();
  final snack = Modular.get<CustomSnack>();
  final formKey = GlobalKey<FormState>();
  late CursoModel newCurso;
  bool loading = false;
  int? matriculas;

  @override
  void initState() {
    newCurso = widget.model.copyWith();
    WidgetsBinding.instance.addPostFrameCallback((_) => getMatriculas());
    super.initState();
  }

  Future<void> getMatriculas() async {
    int? res = await controller.getCursoMatriculas(id: widget.model.codigo!);
    setState(() => matriculas = res);
  }

  Future<void> onSubmit() async {
    if (!formKey.currentState!.validate()) {
      snack.error(text: "Preencha os campos corretamente para continuar");
      return;
    }
    setState(() => loading = true);
    await controller.updateCurso(model: newCurso);
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.descricao!),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Detalhes do curso", style: AppText.title),
                const SizedBox(height: 22),
                TextFormField(
                  initialValue: widget.model.descricao,
                  onChanged: (value) => newCurso.descricao = value,
                  validator: FieldValidation.instance.commonField,
                  decoration: const InputDecoration(
                    hintText: "Descrição do curso",
                    labelText: "Descrição",
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: widget.model.ementa,
                  onChanged: (value) => newCurso.ementa = value,
                  validator: FieldValidation.instance.commonField,
                  decoration: const InputDecoration(
                    hintText: "Ementa do curso",
                    labelText: "Ementa",
                  ),
                ),
                const SizedBox(height: 22),
                ElevatedButton(
                  onPressed: loading ? null : onSubmit,
                  child: loading
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
                if (matriculas != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Alunos matriculados",
                                style: AppText.title,
                              ),
                              const SizedBox(width: 8),
                              TurmaStatus(alunos: matriculas!),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text.rich(
                            TextSpan(
                              text: matriculas.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                              children: const [
                                TextSpan(text: " / "),
                                TextSpan(
                                  text: " 10",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
