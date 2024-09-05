// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curso_aluno_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CursoAlunoModel _$CursoAlunoModelFromJson(Map<String, dynamic> json) =>
    CursoAlunoModel(
      id: (json['id'] as num?)?.toInt(),
      codigo: (json['codigo'] as num).toInt(),
      codigoAluno: (json['codigoAluno'] as num).toInt(),
      codigoCurso: (json['codigoCurso'] as num).toInt(),
    );

Map<String, dynamic> _$CursoAlunoModelToJson(CursoAlunoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'codigo': instance.codigo,
      'codigoAluno': instance.codigoAluno,
      'codigoCurso': instance.codigoCurso,
    };
