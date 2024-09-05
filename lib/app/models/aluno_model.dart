import 'package:json_annotation/json_annotation.dart';

part 'aluno_model.g.dart';

@JsonSerializable()
class AlunoModel {
  int? codigo;
  String? name;

  AlunoModel({this.codigo, this.name});

  factory AlunoModel.fromJson(Map<String, dynamic> json) =>
      _$AlunoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlunoModelToJson(this);
}
