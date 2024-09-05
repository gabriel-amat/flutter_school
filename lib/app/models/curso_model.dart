// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'curso_model.g.dart';

@JsonSerializable()
class CursoModel {
  int? codigo;
  String? descricao;
  String? ementa;

  CursoModel({
    this.codigo,
    this.descricao,
    this.ementa,
  });

  factory CursoModel.fromJson(Map<String, dynamic> json) =>
      _$CursoModelFromJson(json);

  Map<String, dynamic> toJson() => _$CursoModelToJson(this);

  CursoModel copyWith({
    int? id,
    int? codigo,
    String? descricao,
    String? ementa,
  }) {
    return CursoModel(
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      ementa: ementa ?? this.ementa,
    );
  }
}
