import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neopop/neopop.dart';

import 'home_controller.dart';
import 'widgets/boat_widget.dart';
import 'widgets/play_ground_widget.dart';
import 'widgets/subject_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.blue.shade300,
          body: Stack(
            children: [
              PlayGroundWidget(
                leftSideWidget: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: controller.leftSide
                      .map(
                        (subject) => SubjectWidget(
                          subject: subject,
                          onSubjectTap: controller.onSubjectTap,
                        ),
                      )
                      .toList(),
                ),
                centerWidget: Stack(
                  children: [
                    BoatWidget(
                      isBoatOnLeftSide: controller.isBoatOnLeftSide,
                      alignment: controller.alignment,
                      subjects: controller.onBoat,
                      onSubjectTap: controller.onSubjectTap,
                    ),
                  ],
                ),
                rightSideWidget: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: controller.rightSide
                      .map(
                        (subject) => SubjectWidget(
                          subject: subject,
                          onSubjectTap: controller.onSubjectTap,
                        ),
                      )
                      .toList(),
                ),
                bottomLeftSideWidget: _buildMoveBoatButton(
                  controller.moveBoat,
                ),
                bottomRightSideWidget: _buildMoveBoatButton(
                  controller.moveBoat,
                ),
                bottomCenterWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (controller.isGameStarted && !controller.isGameEnded)
                      StreamBuilder(
                        stream: controller.gameStream,
                        builder: (context, snapshot) {
                          return Text(
                            controller.playingTime(),
                            style: const TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    if (controller.isGameEnded)
                      Text(
                        controller.gameTime(),
                        style: const TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
              if (controller.disableInteraction)
                const ModalBarrier(
                  dismissible: false,
                  color: Colors.transparent,
                ),
              if (!controller.isGameStarted)
                ..._buildStartGameWidgets(
                  controller.startGame,
                ),
              if (controller.isGameEnded)
                ..._buildEndGameWidgets(
                  controller.resetGame,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMoveBoatButton(Function moveBoat) {
    return Center(
      child: NeoPopTiltedButton(
        onTapUp: () => moveBoat(),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 80.0,
            vertical: 15,
          ),
          child: Text('Move boat'),
        ),
      ),
    );
  }

  List<Widget> _buildStartGameWidgets(startGame) {
    return [
      ModalBarrier(
        dismissible: false,
        color: Colors.grey.withOpacity(0.5),
      ),
      Center(
        child: NeoPopTiltedButton(
          color: Colors.green,
          onTapUp: () => startGame(),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 80.0,
              vertical: 15,
            ),
            child: Text('Start'),
          ),
        ),
      )
    ];
  }

  List<Widget> _buildEndGameWidgets(resetGame) {
    return [
      ModalBarrier(
        dismissible: false,
        color: Colors.red.withOpacity(0.5),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NeoPopTiltedButton(
              color: Colors.orange,
              onTapUp: () => resetGame(),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 15,
                ),
                child: Text('Reset Game'),
              ),
            ),
            NeoPopTiltedButton(
              color: Colors.orange,
              onTapUp: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 80.0,
                  vertical: 15,
                ),
                child: Text('Leader Board'),
              ),
            ),
          ],
        ),
      )
    ];
  }
}
