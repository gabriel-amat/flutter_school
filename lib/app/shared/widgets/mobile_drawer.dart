import 'package:flutter/material.dart';

import '../../config/theme/app_text.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Flutter School",
              style: AppText.bigTitle.copyWith(color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.exit_to_app_rounded),
                const SizedBox(width: 5),
                Text(
                  "Sair",
                  style: AppText.menuItem.copyWith(color: Colors.black),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
