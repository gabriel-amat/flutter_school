import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/app/models/curso_model.dart';
import 'package:school/modules/cursos/controller/curso_controller.dart';
import 'package:school/modules/cursos/widgets/curso_card.dart';

class CursoListWidget extends StatefulWidget {
  final List<CursoModel> list;
  final TextEditingController searchController;

  const CursoListWidget({
    super.key,
    required this.list,
    required this.searchController,
  });

  @override
  State<CursoListWidget> createState() => _CursoListWidgetState();
}

class _CursoListWidgetState extends State<CursoListWidget> {
  final controller = Modular.get<CursoController>();
  final bool isLoading = false;
  List<CursoModel> filteredList = [];

  @override
  void initState() {
    filteredList = widget.list;
    widget.searchController.addListener(filterData);
    super.initState();
  }

  @override
  void dispose() {
    widget.searchController.removeListener(filterData);
    super.dispose();
  }

  void filterData() {
    if (widget.searchController.text.isEmpty) {
      setState(() => filteredList = widget.list);
      return;
    }

    if (widget.searchController.text.length < 3) {
      return;
    }

    final query = widget.searchController.text.toLowerCase();

    filteredList = controller.filterCurso(widget.list, query);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (filteredList.isEmpty) {
      return const Center(
        child: Text("Nenhum curso encontrado"),
      );
    }
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return CursoCard(model: filteredList[index]);
      },
    );
  }
}
