// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curso_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CursoModel _$CursoModelFromJson(Map<String, dynamic> json) => CursoModel(
      codigo: (json['codigo'] as num?)?.toInt(),
      descricao: json['descricao'] as String?,
      ementa: json['ementa'] as String?,
    );

Map<String, dynamic> _$CursoModelToJson(CursoModel instance) =>
    <String, dynamic>{
      'codigo': instance.codigo,
      'descricao': instance.descricao,
      'ementa': instance.ementa,
    };
