import 'package:json_annotation/json_annotation.dart';

part 'curso_aluno_model.g.dart';

@JsonSerializable()
class CursoAlunoModel {
  int? id;
  int codigo;
  int codigoAluno;
  int codigoCurso;
  
  CursoAlunoModel({
    this.id,
    required this.codigo,
    required this.codigoAluno,
    required this.codigoCurso,
  });

  factory CursoAlunoModel.fromJson(Map<String, dynamic> json) =>
      _$CursoAlunoModelFromJson(json);

  Map<String, dynamic> toJson() => _$CursoAlunoModelToJson(this);
}
