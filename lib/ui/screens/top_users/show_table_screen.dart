import 'package:flutter/material.dart';

import '../../../data/models/user.dart';
import 'text_of_data_table.dart';

class ShowTableScreen extends StatelessWidget {
  final List<User> userList;
  const ShowTableScreen({super.key, required this.userList});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(
          label: TextOfDataTable(strName: "Name", columnHeader: true),
        ),
        DataColumn(
          label: TextOfDataTable(strName: "Email", columnHeader: true),
        ),
        DataColumn(
          label: TextOfDataTable(strName: "Score", columnHeader: true),
        ),
      ],
      rows: userList.map((user) {
        return DataRow(
          cells: [
            DataCell(
              TextOfDataTable(strName: user.displayName, columnHeader: false),
            ),
            DataCell(TextOfDataTable(strName: user.email, columnHeader: false)),
            DataCell(
              TextOfDataTable(
                strName: user.score.toString(),
                columnHeader: false,
              ),
            ),
          ],
        );
      }).toList(),
      border: TableBorder.all(
        width: 0.5,
        color: Colors.white,
      ),
    );
  }
}
