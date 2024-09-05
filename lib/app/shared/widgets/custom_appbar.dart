import 'package:flutter/material.dart';

import 'notification_icon_widget.dart';
import 'user_icon_widget.dart';

class CustomAppbar extends StatelessWidget {
  final String title;

  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: const [
        NotificationIconWidget(),
        SizedBox(width: 16),
        UserIconWidget(),
        SizedBox(width: 16),
      ],
    );
  }
}
