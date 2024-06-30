import 'package:flutter/material.dart';

class TextCell extends StatelessWidget {
  final String text;
  final bool columnHeader;

  const TextCell(
    this.text, {
    super.key,
    required this.columnHeader,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: columnHeader ? FontWeight.bold : FontWeight.normal,
          ),
    );
  }
}
