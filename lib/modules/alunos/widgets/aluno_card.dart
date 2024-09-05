import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school/app/config/app_routes.dart';
import 'package:school/app/config/theme/app_text.dart';
import 'package:school/app/models/aluno_model.dart';

class AlunoCard extends StatelessWidget {
  final AlunoModel model;

  const AlunoCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed(AppRoutes.alunoDetailPage, arguments: model);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              CircleAvatar(
                child: Text(
                  model.name!.substring(0, 1).toUpperCase(),
                  style: AppText.title,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.name!, style: AppText.title),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      text: "Código: ",
                      style: const TextStyle(fontWeight: FontWeight.w300),
                      children: [
                        TextSpan(
                          text: model.codigo.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
