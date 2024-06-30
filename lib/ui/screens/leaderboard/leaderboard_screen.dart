import 'package:flutter/material.dart';

import '../../../app/repo/repos.dart';
import '../../../data/models/app_response.dart';
import '../../../data/models/user.dart';
import '../../utils/constant.dart';
import '../home/widgets/footer.dart';
import 'widgets/user_table_widget.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.leaderboard,
              color: Colors.black,
            ),
            Text("LeaderBoard!"),
          ],
        ),
        centerTitle: true,
        leading: const CloseButton(),
      ),
      body: Column(
        children: [
          Flexible(
            child: SingleChildScrollView(
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

                            return UserTableWidget(users: userList);
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
          const Footer(),
        ],
      ),
    );
  }
}
