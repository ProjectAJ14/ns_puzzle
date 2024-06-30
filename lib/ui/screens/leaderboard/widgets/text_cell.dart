import 'package:flutter/material.dart';

class TextCell extends StatelessWidget {
  final String text;
  final bool isHeader;

  const TextCell(
    this.text, {
    super.key,
    required this.isHeader,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          ),
    );
  }
}
