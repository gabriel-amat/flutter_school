import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/app/config/custom_snack.dart';
import 'package:school/app/models/aluno_model.dart';
import 'package:school/app/config/app_http_client.dart';
import 'package:school/app/models/curso_model.dart';
import 'package:school/app/utils/handler_errors.dart';

class AlunoRepository {
  final httpClient = AppHttpClient.instance;
  final snack = Modular.get<CustomSnack>();

  Future<List<AlunoModel>> getAlunos() async {
    debugPrint("--GetAlunos--");
    try {
      final res = await httpClient.dio.get("/alunos");
      snack.success(text: "Sucesso ao retornar lista de alunos");
      return List<AlunoModel>.from(
        res.data.map((e) => AlunoModel.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      debugPrint("--GetAlunos Error: $e--");
      HandlerErrors.error(e, "Erro ao retornar lista de alunos");
      return [];
    }
  }

  Future<bool> addAluno({required AlunoModel model}) async {
    debugPrint("--AddAlunos--");
    try {
      await httpClient.dio.post("/alunos", data: model.toJson());
      snack.success(text: "Sucesso ao adicionar aluno");
      return true;
    } on DioException catch (e) {
      debugPrint("--AddAlunos Error: $e--");
      HandlerErrors.error(e, "Erro ao cadastrar aluno");
      return false;
    }
  }

  Future<bool> updateAluno({required AlunoModel model}) async {
    debugPrint("--updateAluno--");
    try {
      await httpClient.dio.patch("/aluno", data: model.toJson());
      snack.success(text: "Sucesso ao atualizar dados do aluno");
      return true;
    } on DioException catch (e) {
      debugPrint("--updateAluno Error: $e--");
      HandlerErrors.error(e, "Erro ao atualizar dados do aluno");
      return false;
    }
  }

  Future<List<CursoModel>> getAlunoCursos({required int id}) async {
    debugPrint("--GetAlunoCurso--");
    try {
      final res = await httpClient.dio.get(
        "/cursos/aluno",
        queryParameters: {"userId": id},
      );

      return List<CursoModel>.from(
        res.data.map((e) => CursoModel.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      debugPrint("--GetAlunoCurso Error: $e--");
      HandlerErrors.error(e, "Erro ao retornar cursos matriculados");
      return [];
    }
  }
}
