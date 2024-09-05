import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:school/app/models/aluno_model.dart';
import 'package:school/app/models/curso_model.dart';
import 'package:school/modules/alunos/repository/aluno_repository.dart';
import 'package:school/modules/cursos/repository/curso_repository.dart';

import 'repository_test.mocks.dart';

@GenerateMocks([AlunoRepository, CursoRepository])
void main() {
  late MockAlunoRepository alunoRepository;
  late MockCursoRepository cursoRepository;

  setUp(() {
    alunoRepository = MockAlunoRepository();
    cursoRepository = MockCursoRepository();
  });

  group('Aluno', () {
    test("Cadastrar aluno", () async {
      final aluno = AlunoModel(name: "Gabriel");

      when(alunoRepository.addAluno(model: aluno))
          .thenAnswer((_) async => true);

      final res = await alunoRepository.addAluno(model: aluno);
      expect(res, true);
    });
    test("Retornar lista de alunos", () async {
      when(alunoRepository.getAlunos()).thenAnswer((_) async => []);
      final res = await alunoRepository.getAlunos();
      expect(res, []);
    });
  });

  group('Curso', () {
    test("Cadastrar curso", () async {
      final model = CursoModel(descricao: "Descricao", ementa: "Ementa");

      when(cursoRepository.addCurso(model: model))
          .thenAnswer((_) async => true);

      final resultado = await cursoRepository.addCurso(model: model);
      expect(resultado, true);
    });
    test("Retornar lista de cursos", () async {
      when(cursoRepository.getCursos()).thenAnswer((_) async => []);
      final res = await cursoRepository.getCursos();
      expect(res, []);
    });
  });
}
