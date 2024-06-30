import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

import '../../../../data/models/user.dart';
import 'text_cell.dart';

class UserTableWidget extends StatelessWidget {
  final List<User> users;

  const UserTableWidget({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return NesWindow(
      child: DataTable(
        columns: const [
          DataColumn(label: TextCell("Name", columnHeader: true)),
          DataColumn(label: TextCell("Email", columnHeader: true)),
          DataColumn(label: TextCell("Score", columnHeader: true)),
        ],
        rows: users.map((user) {
          return DataRow(
            cells: [
              DataCell(TextCell(user.displayName, columnHeader: false)),
              DataCell(TextCell(user.email, columnHeader: false)),
              DataCell(TextCell(user.score.toString(), columnHeader: false)),
            ],
          );
        }).toList(),
      ),
    );
  }
}
