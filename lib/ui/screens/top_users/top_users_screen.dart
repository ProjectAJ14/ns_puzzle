import 'package:flutter/material.dart';

import '../../../data/models/app_response.dart';
import '../../../data/models/user.dart';
import '../../../data/services/firestore/firestore_service.dart';
import '../../utils/constant.dart';

class TopUserScreen extends StatelessWidget {
  const TopUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, snapshot) {
        var quarterTurns = 0;
        if (snapshot.maxWidth < snapshot.maxHeight) {
          quarterTurns = 1;
        }

        return RotatedBox(
          quarterTurns: quarterTurns,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Top 10 Winners !"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FutureBuilder(
                    future: fireStore.getAllTopScoredUsers(),
                    builder: (ctx, snapshot) {
                      // Checking if future is resolved
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If we got an error
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${snapshot.error} occurred',
                            ),
                          );

                          // if we got our data
                        } else if (snapshot.hasData) {
                          // Extracting data from snapshot object
                          AppResponse appResponse =
                              snapshot.data as AppResponse;
                          if (appResponse.isSuccess) {
                            List<User> userList = appResponse
                                .data[Constants.userList] as List<User>;

                            return DataTable(
                              columns: [
                                DataColumn(
                                  label: setTextValue("Name", true),
                                ),
                                DataColumn(
                                  label: setTextValue("Email", true),
                                ),
                                DataColumn(
                                  label: setTextValue("Score", true),
                                ),
                              ],
                              rows: userList.map((user) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      setTextValue(user.displayName, false),
                                    ),
                                    DataCell(setTextValue(user.email, false)),
                                    DataCell(
                                      setTextValue(
                                        user.score.toString(),
                                        false,
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
                          } else {
                            return Text(appResponse.message);
                          }
                        }
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget setHeadLines() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          setTextValue("Name", true),
          setTextValue("Email", true),
          setTextValue("Score", true),
        ],
      ),
    );
  }

  Widget setValues(User user) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          setTextValue(user.displayName, false),
          setTextValue(user.email, false),
          setTextValue(user.score.toString(), false),
        ],
      ),
    );
  }

  Widget setTextValue(String strName, bool columnHeader) {
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
