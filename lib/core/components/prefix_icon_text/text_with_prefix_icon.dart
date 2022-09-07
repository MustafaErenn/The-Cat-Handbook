import 'package:cat_breeds_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class TextWithPrefixIcon extends StatelessWidget {
  final String value;
  final IconData icon;
  const TextWithPrefixIcon(
      {super.key, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        Text(
          value,
          style: context.textTheme.titleMedium?.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
