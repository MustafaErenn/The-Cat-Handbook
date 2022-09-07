import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildDivider()),
        Text(text),
        Expanded(child: _buildDivider()),
      ],
    );
  }

  Divider _buildDivider() {
    return const Divider(
      height: 10,
      thickness: 1.5,
      color: Colors.grey,
    );
  }
}
