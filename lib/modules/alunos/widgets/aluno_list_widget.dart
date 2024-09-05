import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/modules/alunos/controller/aluno_controller.dart';
import 'package:school/modules/alunos/widgets/aluno_card.dart';

import '../../../app/models/aluno_model.dart';

class AlunoListWidget extends StatefulWidget {
  final List<AlunoModel> list;
  final TextEditingController searchController;

  const AlunoListWidget({
    super.key,
    required this.list,
    required this.searchController,
  });

  @override
  State<AlunoListWidget> createState() => _AlunoListWidgetState();
}

class _AlunoListWidgetState extends State<AlunoListWidget> {
  final alunoController = Modular.get<AlunoController>();
  final bool isLoading = false;
  List<AlunoModel> filteredList = [];

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

    debugPrint("--Filtrando alunos--");
    final query = widget.searchController.text.toLowerCase();
    filteredList = alunoController.filterAlunos(widget.list, query);
    debugPrint("Lista filtrada: $filteredList");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (filteredList.isEmpty) {
      return const Center(
        child: Text("Nenhum aluno encontrado com os dados dessa busca"),
      );
    }
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return AlunoCard(model: filteredList[index]);
      },
    );
  }
}
