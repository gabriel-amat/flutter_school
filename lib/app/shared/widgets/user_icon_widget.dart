import 'package:flutter/material.dart';

class UserIconWidget extends StatelessWidget {
  const UserIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      child: Icon(Icons.person_outline_rounded),
    );
  }
}
