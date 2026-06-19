import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  final String question;
  final String action;
  final VoidCallback onTap;

  const AuthFooter({
    super.key,
    required this.question,
    required this.action,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(question),
        TextButton(onPressed: onTap, child: Text(action)),
      ],
    );
  }
}
