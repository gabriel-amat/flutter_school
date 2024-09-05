import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/app/config/custom_snack.dart';
import 'package:school/modules/alunos/aluno_detail_page.dart';
import 'package:school/modules/alunos/controller/aluno_controller.dart';
import 'package:school/modules/alunos/repository/aluno_repository.dart';
import 'package:school/modules/cursos/controller/curso_controller.dart';
import 'package:school/modules/cursos/curso_detail_page.dart';
import 'package:school/modules/cursos/repository/curso_repository.dart';
import '../modules/alunos/aluno_page.dart';
import '../modules/cursos/curso_page.dart';
import '../modules/home/home_page.dart';
import 'config/app_routes.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.add(AlunoRepository.new);
    i.addSingleton(AlunoController.new);
    i.add(CursoRepository.new);
    i.addSingleton(CursoController.new);
    i.addSingleton(CustomSnack.new);
  }

  @override
  void routes(r) {
    r.child(AppRoutes.initial, child: (context) => const HomePage(), children: [
      ChildRoute(AppRoutes.alunoPage, child: (context) => const AlunoPage()),
      ChildRoute(AppRoutes.cursoPage, child: (context) => const CursoPage()),
    ]);
    r.child(
      AppRoutes.cursoDetailPage,
      child: (context) => CursoDetailPage(model: r.args.data),
    );
    r.child(
      AppRoutes.alunoDetailPage,
      child: (context) => AlunoDetailPage(model: r.args.data),
    );
  }
}
