import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:school/app/models/curso_aluno_model.dart';
import 'package:school/app/models/curso_model.dart';
import 'package:school/modules/cursos/repository/curso_repository.dart';

part 'curso_controller.g.dart';

class CursoController = CursoControllerBase with _$CursoController;

abstract class CursoControllerBase with Store {
  final repository = Modular.get<CursoRepository>();

  @observable
  var cursos = ObservableList<CursoModel>();

  @observable
  bool isLoading = false;

  @action
  Future<void> getCursos({required bool update}) async {
    if (cursos.isEmpty || update) {
      isLoading = true;
      cursos.clear();
      cursos.addAll(await repository.getCursos());
      isLoading = false;
    }
  }

  Future<void> addCurso({required CursoModel model}) async {
    bool res = await repository.addCurso(model: model);
    if (res) getCursos(update: true);
  }

  Future<bool> addAlunoCurso({required CursoAlunoModel model}) async {
    return await repository.addAlunoCurso(model: model);
  }

  Future<int?> getCursoMatriculas({required int id}) async {
    return await repository.getCursoMatriculas(id: id);
  }

  Future<void> updateCurso({required CursoModel model}) async {
    bool res = await repository.updateCurso(model: model);
    if (res) getCursos(update: true);
  }

  List<CursoModel> filterCurso(List<CursoModel> list, String query) {
    final normalizedString = normalizeString(query);
    return list
        .where((e) => matchQuery(e.descricao!, normalizedString))
        .toList();
  }

  bool matchQuery(String userName, String query) {
    List<String> queryWords = query.split("");
    List<String> descWords = userName.split("");

    // Verifica se todas as palavras da query estão presentes nas palavras da descricao
    //Remover pontuação do nome do usuario tambem [normalizeString(userWord)]
    return queryWords.every(
      (e) => descWords.any(
        (desc) => normalizeString(desc).contains(e),
      ),
    );
  }

  //Remove pontuação
  String normalizeString(String input) {
    return input.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '').trim();
  }
}
