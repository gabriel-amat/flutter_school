import 'package:flutter/material.dart';

class TurmaStatus extends StatelessWidget {
  final int alunos;

  const TurmaStatus({super.key, required this.alunos});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: getColor(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Text(
          getLabel(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  String getLabel() => switch (alunos) {
        < 10 => "Turma aberta",
        _ => "Turma cheia",
      };

  Color getColor() => switch (alunos) {
        < 10 => Colors.green,
        _ => Colors.red,
      };
}
