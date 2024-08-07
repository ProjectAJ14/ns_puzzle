import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nes_ui/nes_ui.dart';

import '../../../app/repo/repos.dart';
import '../../routes/route_constants.dart';
import 'widgets/user_table_widget.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height < size.width ? size.height : size.width;
    final width = size.height < size.width ? size.width : size.height;

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
        leading: CloseButton(
          onPressed: () {
            Get.offAllNamed(RouteConstants.home);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height * 1.5,
          width: width,
          child: Center(
            child: StreamBuilder(
              stream: fireStoreRepo.leaderboardStream(),
              builder: (ctx, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                    ),
                  );
                } else if (snapshot.hasData) {
                  final users = snapshot.data;

                  if (users != null) {
                    final highestScorer = users.isNotEmpty ? users[0] : null;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (highestScorer != null) ...[
                          Icon(
                            Icons.emoji_events,
                            size: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Text(
                            highestScorer.score.toString(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            highestScorer.displayName,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            highestScorer.email,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            indent: 10,
                          ),
                        ],
                        Flexible(child: UserTableWidget(users: users)),
                      ],
                    );
                  } else {
                    return const Text('No data found');
                  }
                }
                return const NesHourglassLoadingIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
