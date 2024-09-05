import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/app/config/app_http_client.dart';
import 'package:school/app/models/curso_aluno_model.dart';
import 'package:dio/dio.dart';
import 'package:school/app/models/curso_model.dart';
import 'package:school/app/utils/handler_errors.dart';

import '../../../app/config/custom_snack.dart';

class CursoRepository {
  final httpClient = AppHttpClient.instance;
  final snack = Modular.get<CustomSnack>();

  Future<List<CursoModel>> getCursos() async {
    debugPrint("--GetCursos--");
    try {
      final res = await httpClient.dio.get("/cursos");

      return List<CursoModel>.from(
        res.data.map((e) => CursoModel.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      debugPrint("--GetCursos Error: $e--");
      HandlerErrors.error(e, 'Erro ao retornar lista de cursos');
      return [];
    }
  }

  Future<int?> getCursoMatriculas({required int id}) async {
    debugPrint("--getCursoMatriculas--");
    try {
      final res = await httpClient.dio.get(
        "/curso/matriculas",
        queryParameters: {"cursoId": id},
      );
      return res.data["alunos_matriculados"];
    } on DioException catch (e) {
      debugPrint("--getCursoMatriculas Error: $e--");
      HandlerErrors.error(
        e,
        'Erro ao retornar quantidade de alunos matriculados',
      );
      return null;
    }
  }

  Future<bool> addCurso({required CursoModel model}) async {
    debugPrint("--AddCurso--");
    try {
      await httpClient.dio.post("/cursos", data: model.toJson());
      snack.success(text: "Curso adicionado com sucesso");
      return true;
    } on DioException catch (e) {
      debugPrint("--AddCurso Error: $e--");
      HandlerErrors.error(e, 'Erro ao retornar lista de cursos');
      return false;
    }
  }

  Future<bool> addAlunoCurso({required CursoAlunoModel model}) async {
    debugPrint("--AddAlunoCurso--");
    try {
      await httpClient.dio.post("/cursos/aluno", data: model.toJson());
      snack.success(text: "Aluno matriculado com sucesso");
      return true;
    } on DioException catch (e) {
      debugPrint("--AddAlunoCurso Error: $e--");
      HandlerErrors.error(e, 'Erro ao matricular aluno');
      return false;
    }
  }

  Future<bool> updateCurso({required CursoModel model}) async {
    debugPrint("--updateCurso--");
    try {
      await httpClient.dio.patch("/curso", data: model.toJson());
      snack.success(text: "Curso atualizado com sucesso");
      return true;
    } on DioException catch (e) {
      debugPrint("--updateCurso Error: $e--");
      HandlerErrors.error(e, "Erro ao atualizar curso");
      return false;
    }
  }
}
