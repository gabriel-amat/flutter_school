import 'package:flutter/material.dart';
import 'package:school/app/config/theme/app_colors.dart';

class NotificationIconWidget extends StatelessWidget {
  const NotificationIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Badge(
      label: Text("4"),
      backgroundColor: AppColors.secondary,
      child: Icon(Icons.notifications, color: Colors.grey),
    );
  }
}
