// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aluno_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AlunoController on AlunoControllerBase, Store {
  late final _$alunosAtom =
      Atom(name: 'AlunoControllerBase.alunos', context: context);

  @override
  ObservableList<AlunoModel> get alunos {
    _$alunosAtom.reportRead();
    return super.alunos;
  }

  @override
  set alunos(ObservableList<AlunoModel> value) {
    _$alunosAtom.reportWrite(value, super.alunos, () {
      super.alunos = value;
    });
  }

  late final _$alunoCursosAtom =
      Atom(name: 'AlunoControllerBase.alunoCursos', context: context);

  @override
  ObservableList<CursoModel> get alunoCursos {
    _$alunoCursosAtom.reportRead();
    return super.alunoCursos;
  }

  @override
  set alunoCursos(ObservableList<CursoModel> value) {
    _$alunoCursosAtom.reportWrite(value, super.alunoCursos, () {
      super.alunoCursos = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'AlunoControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$getAlunosAsyncAction =
      AsyncAction('AlunoControllerBase.getAlunos', context: context);

  @override
  Future<void> getAlunos({required bool update}) {
    return _$getAlunosAsyncAction.run(() => super.getAlunos(update: update));
  }

  late final _$getAlunoCursosAsyncAction =
      AsyncAction('AlunoControllerBase.getAlunoCursos', context: context);

  @override
  Future<void> getAlunoCursos({required bool update, required int userId}) {
    return _$getAlunoCursosAsyncAction
        .run(() => super.getAlunoCursos(update: update, userId: userId));
  }

  @override
  String toString() {
    return '''
alunos: ${alunos},
alunoCursos: ${alunoCursos},
isLoading: ${isLoading}
    ''';
  }
}
