import 'package:flutter/material.dart';

class TextOfDataTable extends StatelessWidget {
  final String strName;
  final bool columnHeader;
  const TextOfDataTable({
    super.key,
    required this.strName,
    required this.columnHeader,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      strName,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Colors.white,
        fontWeight: columnHeader ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
