// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aluno_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlunoModel _$AlunoModelFromJson(Map<String, dynamic> json) => AlunoModel(
      codigo: (json['codigo'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$AlunoModelToJson(AlunoModel instance) =>
    <String, dynamic>{
      'codigo': instance.codigo,
      'name': instance.name,
    };
