import 'package:flutter/material.dart';

import '../../../../data/models/user.dart';
import 'text_cell.dart';

class UserTableWidget extends StatelessWidget {
  final List<User> users;

  const UserTableWidget({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 8,
      columns: const [
        DataColumn(label: TextCell("Rank", isHeader: true)),
        DataColumn(label: TextCell("Name", isHeader: true)),
        DataColumn(label: TextCell("Email", isHeader: true)),
        DataColumn(label: TextCell("Score", isHeader: true)),
      ],
      rows: users.map((user) {
        return DataRow(
          cells: [
            DataCell(TextCell('${users.indexOf(user) + 1}', isHeader: false)),
            DataCell(TextCell(user.displayName, isHeader: false)),
            DataCell(TextCell(user.email, isHeader: false)),
            DataCell(TextCell(user.score.toString(), isHeader: false)),
          ],
        );
      }).toList(),
    );
  }
}
