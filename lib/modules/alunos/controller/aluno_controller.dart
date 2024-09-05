import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:school/app/models/aluno_model.dart';
import 'package:school/app/models/curso_model.dart';
import 'package:school/modules/alunos/repository/aluno_repository.dart';

part 'aluno_controller.g.dart';

class AlunoController = AlunoControllerBase with _$AlunoController;

abstract class AlunoControllerBase with Store {
  final repository = Modular.get<AlunoRepository>();

  @observable
  var alunos = ObservableList<AlunoModel>();

  @observable
  var alunoCursos = ObservableList<CursoModel>();

  @observable
  bool isLoading = false;

  @action
  Future<void> getAlunos({required bool update}) async {
    if (alunos.isEmpty || update) {
      isLoading = true;
      alunos.clear();
      alunos.addAll(await repository.getAlunos());
      isLoading = false;
    }
  }

  Future<void> addAluno({required AlunoModel model}) async {
    bool res = await repository.addAluno(model: model);
    if (res) getAlunos(update: true);
  }

  Future<void> updateAluno({required AlunoModel model}) async {
    bool res = await repository.updateAluno(model: model);
    if (res) getAlunos(update: true);
  }

  @action
  Future<void> getAlunoCursos({
    required bool update,
    required int userId,
  }) async {
    if (alunoCursos.isEmpty || update) {
      isLoading = true;
      alunoCursos.clear();
      alunoCursos.addAll(await repository.getAlunoCursos(id: userId));
      isLoading = false;
    }
  }

  //Filter================
  List<AlunoModel> filterAlunos(List<AlunoModel> list, String query) {
    final normalizedString = normalizeString(query);
    return list.where((e) => matchQuery(e.name!, normalizedString)).toList();
  }

  bool matchQuery(String userName, String query) {
    List<String> queryWords = query.split("");
    List<String> userWords = userName.split("");

    // Verifica se todas as palavras da query estão presentes nas palavras do usuário
    //Remover pontuação do nome do usuario tambem [normalizeString(userWord)]
    return queryWords.every(
      (queryWord) => userWords.any(
        (userWord) => normalizeString(userWord).contains(queryWord),
      ),
    );
  }

  //Remove pontuação
  String normalizeString(String input) {
    return input.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '').trim();
  }
}
