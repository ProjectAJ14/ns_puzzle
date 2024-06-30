import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

import '../../../../data/models/user.dart';
import 'text_cell.dart';

class UserTableWidget extends StatelessWidget {
  final List<User> userList;

  const UserTableWidget({super.key, required this.userList});

  @override
  Widget build(BuildContext context) {
    return NesWindow(
      child: DataTable(
        columns: const [
          DataColumn(label: TextCell("Name", columnHeader: true)),
          DataColumn(label: TextCell("Email", columnHeader: true)),
          DataColumn(label: TextCell("Score", columnHeader: true)),
        ],
        rows: userList.map((user) {
          return DataRow(
            cells: [
              DataCell(TextCell(user.displayName, columnHeader: false)),
              DataCell(TextCell(user.email, columnHeader: false)),
              DataCell(TextCell(user.score.toString(), columnHeader: false)),
            ],
          );
        }).toList(),
        border: TableBorder.all(
          width: 0.5,
          color: Colors.white,
        ),
      ),
    );
  }
}
