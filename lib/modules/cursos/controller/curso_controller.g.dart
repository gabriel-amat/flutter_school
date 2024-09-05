// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curso_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CursoController on CursoControllerBase, Store {
  late final _$cursosAtom =
      Atom(name: 'CursoControllerBase.cursos', context: context);

  @override
  ObservableList<CursoModel> get cursos {
    _$cursosAtom.reportRead();
    return super.cursos;
  }

  @override
  set cursos(ObservableList<CursoModel> value) {
    _$cursosAtom.reportWrite(value, super.cursos, () {
      super.cursos = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'CursoControllerBase.isLoading', context: context);

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

  late final _$getCursosAsyncAction =
      AsyncAction('CursoControllerBase.getCursos', context: context);

  @override
  Future<void> getCursos({required bool update}) {
    return _$getCursosAsyncAction.run(() => super.getCursos(update: update));
  }

  @override
  String toString() {
    return '''
cursos: ${cursos},
isLoading: ${isLoading}
    ''';
  }
}
