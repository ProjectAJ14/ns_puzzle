import 'package:flutter/material.dart';

import '../../../app/repo/repos.dart';
import '../../../data/models/app_response.dart';
import '../../../data/models/user.dart';
import '../../utils/constant.dart';
import 'show_table_screen.dart';

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
                    future: fireStoreRepo.getAllTopScoredUsers(),
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

                            return ShowTableScreen(userList: userList);
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
}
